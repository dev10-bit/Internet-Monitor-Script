# Internet-Monitor-Script
A PowerShell script that monitors internet connectivity and displays tray notifications. 
# Internet Connectivity Monitor (PowerShell)

This is a lightweight PowerShell script that monitors your internet connection in real time and alerts you via system tray notifications when your connection is lost or restored. It also logs all events to a `.txt` file with timestamps.

## 🚀 Features

- ✅ Real-time internet status monitoring
- ✅ System tray icon with balloon notifications
- ✅ Logs connection events to `InternetConnectionLog.txt`
- ✅ Tray icon includes a right-click **Exit** option
- ✅ Starts automatically with Windows via Task Scheduler
- ✅ Designed for Windows 10/11

## 🧠 How It Works

- Uses `Test-Connection` to ping `google.com` every 5 seconds.
- Detects internet loss, restoration, and status changes.
- Shows pop-up notifications using `System.Windows.Forms`.
- Keeps a timestamped log of all internet status changes.
- Runs silently in the background at every user login.

## 🔧 Requirements

- Windows 10 or Windows 11
- PowerShell 5.1 or later (built-in on most systems)
- Internet access (obviously!)

## 📁 Files

| File | Purpose |
|------|---------|
| `InternetMonitor_Tray.ps1` | Main PowerShell script |
| `InternetConnectionLog.txt` | Auto-generated log file (excluded via `.gitignore`) |
| `.gitignore` | Keeps logs and system files out of the repo |

## 📦 Installation / Setup

1. Place `InternetMonitor_Tray.ps1` inside a permanent folder (e.g., `C:\Scripts\`).
2. Open **Task Scheduler** → Create a new task:
   - **Trigger:** At log on
   - **Action:** `powershell.exe`
   - **Arguments:**
     ```
     -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Scripts\InternetMonitor_Tray.ps1"
     ```
   - **Run only when user is logged on**
   - **Run with highest privileges**
3. Done! The script will now auto-run at each login.

## 📝 License

This project is licensed under the **MIT License** — feel free to use or adapt it with attribution.

---

Created by [dev10-bit](https://github.com/dev10-bit)
