' Save this as LaunchHidden.vbs
' This script launches the PowerShell script with completely hidden window

' Change the path to match where you saved the PowerShell script
strScriptPath = """C:\zedScript\ScreenTimerNotifier\ScreenTimeoutNotifier.ps1"""

' Create a hidden PowerShell process
Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File " & strScriptPath, 0, False
