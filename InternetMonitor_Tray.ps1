Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Set up paths
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition
$LogPath = "$ScriptDirectory\InternetConnectionLog.txt"

# Create and show tray icon
$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$notifyIcon.Icon = [System.Drawing.SystemIcons]::Information
$notifyIcon.Visible = $true
$notifyIcon.Text = "Internet Monitor"

# Set initial states
$InternetWasOnline = $true
$LastStatusTime = Get-Date

# Exit menu
$exitMenuItem = New-Object System.Windows.Forms.MenuItem "Exit"
$exitMenuItem.add_Click({
    $notifyIcon.Visible = $false
    [System.Windows.Forms.Application]::Exit()
    Stop-Process -Id $PID
})

# Tray menu
$contextMenu = New-Object System.Windows.Forms.ContextMenu
$contextMenu.MenuItems.Add($exitMenuItem)
$notifyIcon.ContextMenu = $contextMenu

# Timer to check internet every 5 seconds
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 5000  # milliseconds (5 seconds)

$timer.Add_Tick({
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Now = Get-Date

    # Double-check to avoid false positives
    $IsOnline = Test-Connection -ComputerName google.com -Count 1 -Quiet
    if (-not $IsOnline) {
        Start-Sleep -Milliseconds 1500
        $IsOnline = Test-Connection -ComputerName google.com -Count 1 -Quiet
    }

    if ($IsOnline) {
        $Message = "$TimeStamp - Internet OK"
        Write-Host $Message -ForegroundColor Green

        # Show "Internet OK" popup once per hour
        if (($Now - $LastStatusTime).TotalMinutes -ge 60) {
            $notifyIcon.ShowBalloonTip(3000, "Internet Status", "Internet is OK as of $TimeStamp", [System.Windows.Forms.ToolTipIcon]::Info)
            $LastStatusTime = $Now
        }

        $InternetWasOnline = $true
    } else {
        $Message = "$TimeStamp - No Internet Connection"
        Write-Host $Message -ForegroundColor Red

        if ($InternetWasOnline) {
            $notifyIcon.ShowBalloonTip(5000, "Internet Connection Lost", "Your PC lost internet access!", [System.Windows.Forms.ToolTipIcon]::Error)
        }

        $InternetWasOnline = $false
        $LastStatusTime = $Now
    }

    Add-Content -Path $LogPath -Value $Message
})

# Start timer and run message loop
$timer.Start()
[System.Windows.Forms.Application]::Run()

