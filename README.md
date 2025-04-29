# Internet-Monitor-Script
A PowerShell script that monitors internet connectivity and displays tray notifications. 

# Internet Connectivity Monitor (PowerShell)

A lightweight PowerShell tool that monitors your internet connection, displays tray notifications, and logs all events — fully automated at Windows startup via Task Scheduler.

## 🚀 Features

- ✅ Real-time internet connection monitoring
- ✅ Tray icon with right-click Exit menu
- ✅ Pop-up notifications for:
  - Internet Lost
  - Internet Restored
  - Internet OK (shown once every 60 minutes)
- ✅ Background logging to `InternetConnectionLog.txt`
- ✅ Automatically launches at login with Task Scheduler
- ✅ Designed for Windows 10/11

## 🧠 How It Works

- Checks internet connectivity by pinging `google.com` every 5 seconds.
- Displays:
  - Immediate alert if the internet is lost or restored.
  - "Internet OK" reminder every 60 minutes if connection is stable.
- Writes every status event to a timestamped `.txt` log file.
- Runs silently in the background with a tray icon.
- Allows clean exit by right-clicking the tray icon and selecting **Exit**.

## 🔧 Requirements

- Windows 10 or Windows 11
- PowerShell 5.1 or later
- Basic Task Scheduler setup (one-time)

## 📁 Project Structure

| File | Purpose |
|------|---------|
| `InternetMonitor_Tray.ps1` | Main PowerShell script |
| `.gitignore` | Excludes logs and temp files |
| `InternetConnectionLog.txt` | Auto-generated log file (ignored in Git) |
| `LICENSE` | MIT License |

## 🛠️ Installation & Setup

1. Save the `InternetMonitor_Tray.ps1` script to a permanent location (e.g., `C:\Scripts\`).
2. Open **Task Scheduler** → Create a new task:
   - **Trigger:** At log on
   - **Action:** Start `powershell.exe`
   - **Arguments:**  
     ```
     -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Scripts\InternetMonitor_Tray.ps1"
     ```
   - **Settings:**  
     - Run only when user is logged on
     - Run with highest privileges
3. Restart or log off/on to test.

✅ The system tray icon will appear automatically, and background monitoring will begin.

## 📝 License

Licensed under the **MIT License** — free to use, modify, and distribute with attribution.

---

Created by [dev10-bit](https://github.com/dev10-bit)
