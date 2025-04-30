# Internet Connectivity Monitor (PowerShell)

A lightweight, automated PowerShell tool that monitors your internet connection in real-time. It logs each status update to a file and displays tray notifications when your internet drops, is restored, or is confirmed stable. Runs silently at startup using Task Scheduler.

---

## 🚀 Features

- ✅ Logs internet connection status every 60 seconds
- ✅ System tray notifications:
  - 🔴 Internet Connection Lost
  - 🟢 Internet Restored
  - ℹ️ Internet OK (every 60 minutes while connected)
- ✅ Persistent logging to `C:\Scripts\InternetConnectionLog.txt`
- ✅ Silent tray app with clean exit via right-click
- ✅ Compatible with Windows 10 and 11
- ✅ Launches automatically at logon via Task Scheduler

---

## 🛠️ Setup Instructions

### 1. Save the script

- Create a folder: `C:\Scripts`
- Save `InternetMonitor_Tray.ps1` inside that folder

### 2. (Optional) View the log file

> `C:\Scripts\InternetConnectionLog.txt`  
Each log entry includes a timestamp and status message.

### 3. Create a Task Scheduler job (runs at startup)

- Open **Task Scheduler**
- Create a new task with these settings:

#### General
- Name: `Internet Monitor`
- ✅ Run only when user is logged on
- ✅ Run with highest privileges

#### Triggers
- At log on

#### Actions
- Program/script:  
  `powershell.exe`

- Add arguments:  
-WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Scripts\InternetMonitor_Tray.ps1"

#### Conditions
- Uncheck all

#### Settings
- ✅ Allow task to be run on demand
- ❌ Do not stop if runs too long
- ✅ Restart task on failure (1 minute, 3 attempts)

---

## 📁 Repository Contents

| File | Description |
|------|-------------|
| `InternetMonitor_Tray.ps1` | Main PowerShell script |
| `README.md` | Setup instructions and feature summary |
| `.gitignore` | Excludes log file from Git tracking |

---

## 📌 Usage Notes

- Runs silently in the background — tray icon appears on logon
- Notifies you only when needed (restored, lost, or hourly confirmation)
- Efficient 60-second check rate for minimal system impact
- Cleanly exits from system tray via right-click → **Exit**

---

## 🔒 Permissions Required

- Administrator access is required to create a Task Scheduler task with elevated privileges
- No changes to firewall or system security settings are made

---

## 📝 License

MIT License — you are free to use, modify, and share this script with attribution.

---

Created by [dev10-bit](https://github.com/dev10-bit)

