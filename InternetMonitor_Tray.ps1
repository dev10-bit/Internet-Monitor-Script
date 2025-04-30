Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$LogPath = "C:\Scripts\InternetConnectionLog.txt"

$notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$notifyIcon.Icon = [System.Drawing.SystemIcons]::Information
$notifyIcon.Visible = $true
$notifyIcon.Text = "Internet Monitor"

$InternetWasOnline = $true
$LastPopupTime = Get-Date

$exitMenuItem = New-Object System.Windows.Forms.MenuItem "Exit"
$exitMenuItem.add_Click({
    $notifyIcon.Visible = $false
    [System.Windows.Forms.Application]::Exit()
    Stop-Process -Id $PID
})

$contextMenu = New-Object System.Windows.Forms.ContextMenu
$contextMenu.MenuItems.Add($exitMenuItem)
$notifyIcon.ContextMenu = $contextMenu

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 60000  # 60 seconds

$timer.Add_Tick({
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Now = Get-Date

    $IsOnline = Test-Connection -ComputerName google.com -Count 1 -Quiet
    if (-not $IsOnline) {
        Start-Sleep -Milliseconds 1500
        $IsOnline = Test-Connection -ComputerName google.com -Count 1 -Quiet
    }

    if ($IsOnline) {
        $Message = "$TimeStamp - Internet OK"
        Write-Host $Message -ForegroundColor Green

        if (-not $InternetWasOnline) {
            $notifyIcon.ShowBalloonTip(5000, "Internet Restored", "Your PC is back online!", [System.Windows.Forms.ToolTipIcon]::Info)
            $InternetWasOnline = $true
            $LastPopupTime = $Now
        } elseif (($Now - $LastPopupTime).TotalMinutes -ge 60) {
            $notifyIcon.ShowBalloonTip(3000, "Internet Status", "Internet is OK as of $TimeStamp", [System.Windows.Forms.ToolTipIcon]::Info)
            $LastPopupTime = $Now
        }

    } else {
        $Message = "$TimeStamp - No Internet Connection"
        Write-Host $Message -ForegroundColor Red

        if ($InternetWasOnline) {
            $notifyIcon.ShowBalloonTip(5000, "Internet Connection Lost", "Your PC lost internet access!", [System.Windows.Forms.ToolTipIcon]::Error)
            $InternetWasOnline = $false
        }
    }

    Add-Content -Path $LogPath -Value $Message
})

$timer.Start()
[System.Windows.Forms.Application]::Run()
