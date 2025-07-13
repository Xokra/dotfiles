# Battery Monitor for Windows with System Tray

# Place this file in C:\zedScript\BatteryMonitor\zedScript\BatteryMonitor.ps1

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Speech

# Configuration
$UPPER_THRESHOLD = 95
$LOWER_THRESHOLD = 30
$CHECK_INTERVAL = 30  # seconds

$LOG_FILE = "C:\zedScript\BatteryMonitor\battery-monitor.log"


# Global variables
$script:lastUpperAlert = 0

$script:lastLowerAlert = 0
$script:notifyIcon = $null
$script:contextMenu = $null
$script:timer = $null
$script:mutex = $null

# Initialize logging
function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    "$timestamp : $Message" | Out-File -FilePath $LOG_FILE -Append -Encoding UTF8
    Write-Host "$timestamp : $Message"
}

# Get battery information
function Get-BatteryInfo {
    $battery = Get-WmiObject -Class Win32_Battery
    return @{
        Percentage = $battery.EstimatedChargeRemaining
        IsCharging = ($battery.BatteryStatus -eq 2)
        Status = $battery.BatteryStatus
    }
}

# Create system tray icon
function Initialize-SystemTray {
    # Create context menu

    $script:contextMenu = New-Object System.Windows.Forms.ContextMenuStrip

    
    # Add menu items

    $statusItem = New-Object System.Windows.Forms.ToolStripMenuItem
    $statusItem.Text = "Battery Monitor Active"
    $statusItem.Enabled = $false
    $script:contextMenu.Items.Add($statusItem)
    
    $script:contextMenu.Items.Add("-")  # Separator
    
    $exitItem = New-Object System.Windows.Forms.ToolStripMenuItem
    $exitItem.Text = "Exit"
    $exitItem.Add_Click({
        Write-Log "Battery monitor stopped by user"
        
        # Cleanup
        if ($script:notifyIcon) {
            $script:notifyIcon.Visible = $false
        }
        if ($script:timer) {
            $script:timer.Stop()
        }
        if ($script:mutex) {

            $script:mutex.ReleaseMutex()
            $script:mutex.Dispose()
        }
        
        [System.Windows.Forms.Application]::Exit()
    })
    $script:contextMenu.Items.Add($exitItem)
    
    # Create system tray icon
    $script:notifyIcon = New-Object System.Windows.Forms.NotifyIcon
    $script:notifyIcon.Icon = [System.Drawing.SystemIcons]::Information
    $script:notifyIcon.Text = "Battery Monitor - Active"
    $script:notifyIcon.Visible = $true
    $script:notifyIcon.ContextMenuStrip = $script:contextMenu
    
    # Add double-click event to show current status
    $script:notifyIcon.Add_DoubleClick({
        $batteryInfo = Get-BatteryInfo
        $chargingStatus = if ($batteryInfo.IsCharging) { "Charging" } else { "Not Charging" }
        Show-BalloonTip "Battery Status" "Battery: $($batteryInfo.Percentage)% - $chargingStatus" "Info"
    })
}

# Show balloon notification
function Show-BalloonTip {

    param(
        [string]$Title,
        [string]$Text,
        [string]$Icon = "Info"  # Info, Warning, Error
    )

    
    $script:notifyIcon.BalloonTipTitle = $Title
    $script:notifyIcon.BalloonTipText = $Text
    

    switch ($Icon) {
        "Warning" { $script:notifyIcon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning }

        "Error" { $script:notifyIcon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Error }

        default { $script:notifyIcon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info }
    }
    
    $script:notifyIcon.ShowBalloonTip(5000)  # Show for 5 seconds
}

# Send alert with multiple notification methods
function Send-Alert {
    param(
        [string]$Message,
        [bool]$IsCritical = $false
    )
    
    Write-Log "ALERT: $Message"
    
    # Update tray icon tooltip (keep under 64 characters)
    $shortMessage = if ($Message.Length -gt 40) { 

        $Message.Substring(0, 37) + "..." 
    } else { 
        $Message 
    }
    $script:notifyIcon.Text = "Battery: $shortMessage"
    

    # Show balloon notification
    $iconType = if ($IsCritical) { "Warning" } else { "Info" }
    Show-BalloonTip "Battery Alert" $Message $iconType
    
    # Voice alert (background job to prevent blocking)
    Start-Job -ScriptBlock {
        param($msg, $isCritical)
        try {
            Add-Type -AssemblyName System.Speech
            $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
            
            # Try to use a friendlier voice if available (prioritize female voices)
            $voices = $speak.GetInstalledVoices()
            $preferredVoices = @(
                "Microsoft Eva Desktop", "Eva", 
                "Microsoft Hazel Desktop", "Hazel",
                "Microsoft Zira Desktop", "Zira",
                "Microsoft David Desktop", "David"
            )
            
            foreach ($preferredVoice in $preferredVoices) {
                $voice = $voices | Where-Object { $_.VoiceInfo.Name -like "*$preferredVoice*" }
                if ($voice) {
                    $speak.SelectVoice($voice.VoiceInfo.Name)
                    break

                }
            }
            
            # Set voice properties for more natural speech
            $speak.Rate = -1     # Slightly slower for clarity
            $speak.Volume = 100  # Maximum volume to compete with media
            
            # Extract battery percentage from message safely
            $batteryPercent = ""
            if ($msg -match "(\d+)%") {
                $batteryPercent = $matches[1] + "%"
            }

            
            # Create more natural, conversational messages
            if ($isCritical) {
                $friendlyMessages = @(
                    "Hey! Your laptop battery is running low$(if($batteryPercent){" at $batteryPercent"}). You should probably plug it in soon.",

                    "Just letting you know, your battery is getting pretty low. Time to find that charger!",
                    "Your battery could really use some power$(if($batteryPercent){" - it's down to $batteryPercent"}). Maybe plug in when you get a chance?",
                    "Battery alert! You're running low on power. Better plug in before it dies on you."
                )
            } else {
                $friendlyMessages = @(
                    "Your battery is all charged up$(if($batteryPercent){" at $batteryPercent"})! You can unplug the charger now if you want.",
                    "Good news - your battery is nice and full. Feel free to unplug and go wireless!",
                    "Your laptop is happy and fully charged! No need to keep it plugged in anymore.",
                    "Battery's looking great$(if($batteryPercent){" at $batteryPercent"})! You can disconnect the charger now."
                )
            }
            
            $randomMessage = $friendlyMessages | Get-Random
            
            # Add pauses for more natural speech
            $naturalMessage = $randomMessage -replace "!", ".  " -replace "\?", ".  "
            
            $speak.Speak($naturalMessage)
        }
        catch {
            # Fallback to simple message if there's an error
            Write-Host "Voice alert error: $($_.Exception.Message)"
        }
    } -ArgumentList $Message, $IsCritical | Out-Null
    
    # For fullscreen applications, also show a message box
    # This will appear on top of most fullscreen applications
    if ($IsCritical) {
        Start-Job -ScriptBlock {
            param($msg)
            Add-Type -AssemblyName System.Windows.Forms
            $form = New-Object System.Windows.Forms.Form
            $form.TopMost = $true
            $form.WindowState = [System.Windows.Forms.FormWindowState]::Maximized
            $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
            $form.BackColor = [System.Drawing.Color]::Black
            $form.Opacity = 0.8
            
            $label = New-Object System.Windows.Forms.Label
            $label.Text = $msg
            $label.ForeColor = [System.Drawing.Color]::White
            $label.Font = New-Object System.Drawing.Font("Arial", 24, [System.Drawing.FontStyle]::Bold)
            $label.AutoSize = $false
            $label.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
            $label.Dock = [System.Windows.Forms.DockStyle]::Fill
            
            $form.Controls.Add($label)
            $form.Show()
            
            # Auto-close after 5 seconds

            $timer = New-Object System.Windows.Forms.Timer
            $timer.Interval = 5000
            $timer.Add_Tick({
                $form.Close()
                $timer.Stop()
            })
            $timer.Start()
            
            # Allow manual close with any key or click
            $form.Add_KeyDown({ $form.Close() })
            $form.Add_Click({ $form.Close() })
            
            [System.Windows.Forms.Application]::Run($form)
        } -ArgumentList $Message | Out-Null

    }
}

# Main battery check function
function Check-Battery {
    $batteryInfo = Get-BatteryInfo
    $currentTime = [DateTimeOffset]::Now.ToUnixTimeSeconds()

    
    Write-Log "Battery: $($batteryInfo.Percentage)%, Charging: $($batteryInfo.IsCharging)"
    
    # Update tray icon tooltip with current status (keep under 64 characters)
    $chargingStatus = if ($batteryInfo.IsCharging) { "Charging" } else { "Not Charging" }
    $statusText = "$($batteryInfo.Percentage)% ($chargingStatus)"
    $script:notifyIcon.Text = "Battery: $statusText"

    
    # Check for high battery when charging
    if ($batteryInfo.IsCharging -and $batteryInfo.Percentage -ge $UPPER_THRESHOLD) {
        if ($script:lastUpperAlert -eq 0) {  # Only alert once when reaching 95%
            Send-Alert "Battery at $($batteryInfo.Percentage)%. Please unplug your charger for battery health." $false
            $script:lastUpperAlert = $currentTime
        }
    } else {
        # Reset upper alert when not charging or below threshold

        if (-not $batteryInfo.IsCharging -or $batteryInfo.Percentage -lt $UPPER_THRESHOLD) {
            $script:lastUpperAlert = 0
        }
    }
    
    # Check for low battery when not charging
    if (-not $batteryInfo.IsCharging -and $batteryInfo.Percentage -le $LOWER_THRESHOLD) {
        # Alert every minute (60 seconds) for low battery
        if (($currentTime - $script:lastLowerAlert) -gt 60) {
            Send-Alert "Battery at $($batteryInfo.Percentage)%. Please plug in your charger!" $true
            $script:lastLowerAlert = $currentTime
        }
    } else {
        # Reset lower alert when charging or above threshold
        if ($batteryInfo.IsCharging -or $batteryInfo.Percentage -gt $LOWER_THRESHOLD) {

            $script:lastLowerAlert = 0
        }
    }
}

# Check for existing instances using mutex
function Test-ExistingInstance {
    try {
        # Try to create a named mutex - only one instance can hold it

        $script:mutex = New-Object System.Threading.Mutex($false, "BatteryMonitor_SingleInstance")
        
        if (-not $script:mutex.WaitOne(0)) {
            Write-Host "Battery monitor is already running. Exiting this instance."
            exit 0
        }
        
        # Also register cleanup when script exits

        Register-EngineEvent PowerShell.Exiting -Action {
            if ($script:mutex) {
                $script:mutex.ReleaseMutex()
                $script:mutex.Dispose()

            }
        } | Out-Null
        
        return $true
    }

    catch {
        Write-Host "Error checking for existing instance: $($_.Exception.Message)"
        return $false
    }
}

# Initialize everything
function Initialize-BatteryMonitor {
    # Check for duplicate instances first

    Test-ExistingInstance
    
    Write-Log "Battery monitor started"
    
    # Create directory if it doesn't exist
    if (-not (Test-Path "C:\zedScript\BatteryMonitor")) {
        New-Item -ItemType Directory -Path "C:\zedScript\BatteryMonitor" -Force
    }

    
    # Initialize system tray

    Initialize-SystemTray
    
    # Show startup notification
    Show-BalloonTip "Battery Monitor" "Battery monitoring started" "Info"
    
    # Create timer for battery checks
    $script:timer = New-Object System.Windows.Forms.Timer

    $script:timer.Interval = ($CHECK_INTERVAL * 1000)  # Convert to milliseconds
    $script:timer.Add_Tick({ Check-Battery })
    $script:timer.Start()
    
    # Initial battery check
    Check-Battery
    
    # Keep the application running
    try {
        [System.Windows.Forms.Application]::Run()
    } finally {
        # Cleanup
        if ($script:notifyIcon) {
            $script:notifyIcon.Visible = $false
            $script:notifyIcon.Dispose()
        }
        if ($script:timer) {

            $script:timer.Stop()

            $script:timer.Dispose()
        }

        if ($script:mutex) {
            $script:mutex.ReleaseMutex()
            $script:mutex.Dispose()

        }
    }
}

# Start the monitor
Initialize-BatteryMonitor
