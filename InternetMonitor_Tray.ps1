
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition
$LogPath = "$ScriptDirectory\InternetConnectionLog.txt"
$InternetWasOnline = $true
$LastStatusTime = Get-Date

# Create tray icon
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$notifyIcon.Icon = [System.Drawing.SystemIcons]::Information
$notifyIcon.Visible = $true
$notifyIcon.Text = "Internet Monitor"
Start-Sleep -Milliseconds 500

# Right-click Exit menu
$exitMenuItem = New-Object System.Windows.Forms.MenuItem "Exit", {
    $notifyIcon.Visible = $false
    Stop-Process -Id $PID
}
$contextMenu = New-Object System.Windows.Forms.ContextMenu
$contextMenu.MenuItems.Add($exitMenuItem)
$notifyIcon.ContextMenu = $contextMenu

# Start monitoring loop
while ($true) {
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $IsOnline = Test-Connection -ComputerName google.com -Count 1 -Quiet
    $Now = Get-Date

    if ($IsOnline) {
        $Message = "$TimeStamp - Internet OK"
        Write-Host $Message -ForegroundColor Green

        # Show "Internet OK" popup every 2 minutes
        if (($Now - $LastStatusTime).TotalMinutes -ge 2) {
            $notifyIcon.ShowBalloonTip(3000, "Internet Status", "Internet is OK as of $TimeStamp", [System.Windows.Forms.ToolTipIcon]::Info)
            $LastStatusTime = $Now
        }

        $InternetWasOnline = $true
    }
    else {
        $Message = "$TimeStamp - No Internet Connection"
        Write-Host $Message -ForegroundColor Red

        # Only show popup when status changes to offline
        if ($InternetWasOnline) {
            $notifyIcon.ShowBalloonTip(5000, "Internet Connection Lost", "Your PC lost internet access!", [System.Windows.Forms.ToolTipIcon]::Error)
        }

        $InternetWasOnline = $false
        $LastStatusTime = $Now  # reset so next Internet OK popup starts fresh
    }

    Add-Content -Path $LogPath -Value $Message
    Start-Sleep -Seconds 5
}
