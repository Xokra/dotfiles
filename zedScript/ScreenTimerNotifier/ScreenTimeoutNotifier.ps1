# Save this as ScreenTimeoutNotifier.ps1
# This script notifies you before screen timeout, includes a toggle to keep the screen on, and suppresses notifications during video playback

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Configuration
$notificationTimeBeforeTimeout = 30  # seconds before timeout to show notification
$checkInterval = 5  # seconds between checks for user activity
$screenTimeoutMinutes = 3  # your current screen timeout setting

# Convert minutes to milliseconds for comparison
$screenTimeoutMs = $screenTimeoutMinutes * 60 * 1000

# Define P/Invoke methods for user activity, window detection, and screen timeout control
Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;

public class UserActivity {
    [DllImport("user32.dll")]
    public static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);
    [StructLayout(LayoutKind.Sequential)]
    public struct LASTINPUTINFO {
        public uint cbSize;
        public uint dwTime;
    }
    public static uint GetIdleTime() {
        LASTINPUTINFO lastInput = new LASTINPUTINFO();
        lastInput.cbSize = (uint)Marshal.SizeOf(lastInput);
        if (GetLastInputInfo(ref lastInput)) {
            return ((uint)Environment.TickCount - lastInput.dwTime);
        }
        return 0;
    }
}

public class WindowDetection {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern int GetWindowText(IntPtr hWnd, StringBuilder text, int count);
    [DllImport("user32.dll")]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
    [StructLayout(LayoutKind.Sequential)]
    public struct RECT {
        public int Left;
        public int Top;
        public int Right;
        public int Bottom;
    }
    public static string GetActiveWindowTitle() {
        const int nChars = 256;
        StringBuilder buff = new StringBuilder(nChars);
        IntPtr handle = GetForegroundWindow();
        if (GetWindowText(handle, buff, nChars) > 0) {
            return buff.ToString();
        }
        return string.Empty;
    }
}

public class ScreenTimeoutControl {
    [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern uint SetThreadExecutionState(uint esFlags);
    public const uint ES_CONTINUOUS = 0x80000000;
    public const uint ES_DISPLAY_REQUIRED = 0x00000002;
}
"@

# Application context to keep script running
$appContext = New-Object System.Windows.Forms.ApplicationContext

# Create notification icon
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$notifyIcon.Icon = [System.Drawing.SystemIcons]::Information
$notifyIcon.Visible = $true
$notifyIcon.Text = "Screen Timeout Notifier"

# Create context menu
$contextMenu = New-Object System.Windows.Forms.ContextMenu

# Add status menu item
$statusMenuItem = New-Object System.Windows.Forms.MenuItem
$statusMenuItem.Text = "Status: Active"
$contextMenu.MenuItems.Add($statusMenuItem)

# Add "Keep Screen On" toggle menu item
$alwaysOn = $false
$keepScreenOnMenuItem = New-Object System.Windows.Forms.MenuItem
$keepScreenOnMenuItem.Text = "Keep Screen On"
$keepScreenOnMenuItem.Checked = $false
$keepScreenOnMenuItem.Add_Click({
    $script:alwaysOn = -not $script:alwaysOn
    $keepScreenOnMenuItem.Checked = $script:alwaysOn
    if ($script:alwaysOn) {
        [ScreenTimeoutControl]::SetThreadExecutionState([ScreenTimeoutControl]::ES_CONTINUOUS -bor [ScreenTimeoutControl]::ES_DISPLAY_REQUIRED)
        $notifyIcon.ShowBalloonTip(3000, "Keep Screen On", "Screen will stay on", [System.Windows.Forms.ToolTipIcon]::Info)
    } else {
        [ScreenTimeoutControl]::SetThreadExecutionState([ScreenTimeoutControl]::ES_CONTINUOUS)
        $notifyIcon.ShowBalloonTip(3000, "Keep Screen On", "Screen timeout restored to 3 minutes", [System.Windows.Forms.ToolTipIcon]::Info)
    }
})
$contextMenu.MenuItems.Add($keepScreenOnMenuItem)

# Add separator
$separator = New-Object System.Windows.Forms.MenuItem
$separator.Text = "-"
$contextMenu.MenuItems.Add($separator)

# Add exit menu item
$exitMenuItem = New-Object System.Windows.Forms.MenuItem
$exitMenuItem.Text = "Exit"
$exitMenuItem.Add_Click({
    $notifyIcon.Visible = $false
    $timer.Stop()
    $timer.Dispose()
    [System.Windows.Forms.Application]::Exit()
})
$contextMenu.MenuItems.Add($exitMenuItem)

$notifyIcon.ContextMenu = $contextMenu

# Show initial notification
$notifyIcon.ShowBalloonTip(3000, "Video-Aware Timeout Notifier", "Running in background - Will detect video playback", [System.Windows.Forms.ToolTipIcon]::Info)

# Create timer for checking idle time
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = $checkInterval * 1000
$notificationShown = $false

# Function to detect video playback or fullscreen mode
function IsVideoPlayerActive {
    $hwnd = [WindowDetection]::GetForegroundWindow()
    $rect = New-Object WindowDetection+RECT
    [WindowDetection]::GetWindowRect($hwnd, [ref]$rect)
    $screenBounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $isFullscreen = ($rect.Left -eq $screenBounds.Left -and $rect.Top -eq $screenBounds.Top -and
                     $rect.Right -eq $screenBounds.Right -and $rect.Bottom -eq $screenBounds.Bottom)
    $windowTitle = [WindowDetection]::GetActiveWindowTitle()
    $videoKeywords = @(
        "YouTube", "Netflix", "Hulu", "Prime Video", "Disney+", "HBO Max",
        "VLC", "Media Player", "video", "player", "movie", "stream",
        "Twitch", "Plex", "mpv", "MPC-HC", "PotPlayer", "TikTok"
    )
    foreach ($keyword in $videoKeywords) {
        if ($windowTitle -like "*$keyword*") {
            return $true
        }
    }
    if ($isFullscreen) {
        return $true
    }
    return $false
}

# Timer tick event to handle notifications and status updates
$timer.Add_Tick({
    if ($alwaysOn) {
        $statusMenuItem.Text = "Status: Keep Screen On"
        return
    }

    # Get current idle time in milliseconds
    $idleTime = [UserActivity]::GetIdleTime()

    # Check if video player is active
    $videoActive = IsVideoPlayerActive

    if ($videoActive) {
        $statusMenuItem.Text = "Status: Video Detected (No Timeout)"
        $script:notificationShown = $false
        return
    } else {
        $statusMenuItem.Text = "Status: Active"
    }

    # Calculate time remaining before timeout
    $timeRemainingMs = $screenTimeoutMs - $idleTime
    $timeRemainingSeconds = [math]::Floor($timeRemainingMs / 1000)

    # Show notification when approaching timeout
    if ($timeRemainingSeconds -le $notificationTimeBeforeTimeout -and $timeRemainingSeconds -gt 0 -and -not $script:notificationShown) {
        $notifyIcon.ShowBalloonTip(5000, "Screen Timeout Warning", "Screen will turn off in $timeRemainingSeconds seconds!", [System.Windows.Forms.ToolTipIcon]::Warning)
        $script:notificationShown = $true
    }

    # Reset notification flag when user is active
    if ($timeRemainingSeconds -gt $notificationTimeBeforeTimeout) {
        $script:notificationShown = $false
    }
})

# Start the timer
$timer.Start()

# Start the application
[System.Windows.Forms.Application]::Run($appContext)