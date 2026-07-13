<div align="center">

# 🌐 Chrome Auto-Installer

**One double-click. Silent install. Chrome ready to go.**

A lightweight Windows utility that downloads, silently installs, and launches Google Chrome — built for first-boot setups, freshly imaged machines, or any PC that needs a browser fast.

![Platform](https://img.shields.io/badge/platform-Windows%2010%2F11-0078D6?logo=windows&logoColor=white)
![Shell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell&logoColor=white)
![License](https://img.shields.io/badge/license-Free%20%26%20Open%20Source-green)

</div>

---

## ✨ Overview

No install wizard. No clicking "Next" five times. No manually setting an execution policy.

Just double-click one file, approve the admin prompt, and Chrome installs itself in the background — opening automatically the moment it's done.

## 📁 Project Structure

```
chrome-auto-installer/
├── Get-Chrome.bat        # Double-click entry point — handles elevation
├── Install-Chrome.ps1    # Core logic — download, install, launch
└── README.md
```

## ⚙️ How It Works

```
 ┌─────────────────┐     elevates (UAC)     ┌──────────────────────┐
 │  Get-Chrome.bat  │ ─────────────────────► │  Install-Chrome.ps1  │
 └─────────────────┘                         └───────────┬──────────┘
                                                           │
                                     ┌─────────────────────┼─────────────────────┐
                                     ▼                     ▼                     ▼
                              Download installer    Silent install        Launch Chrome
```

1. **`Get-Chrome.bat`** checks for admin rights and self-elevates via UAC if needed.
2. It hands off to **`Install-Chrome.ps1`**, which:
   - Downloads the official Google Chrome standalone installer
   - Runs it silently (`/silent /install`, no UI)
   - Deletes the installer once finished
   - Launches Chrome automatically

## 🚀 Usage

1. Clone or download this repo.
2. Keep `Get-Chrome.bat` and `Install-Chrome.ps1` **in the same folder**.
3. Double-click **`Get-Chrome.bat`**.
4. Approve the UAC prompt.
5. Done — Chrome installs and opens on its own.

<details>
<summary>Prefer the command line?</summary>

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\Install-Chrome.ps1
```

</details>

## ✅ Requirements

- Windows 10 or later
- Administrator privileges (machine-wide install)
- Active internet connection

## 🛠 Notes

- Chrome is installed system-wide, available to all users on the machine.
- If the script can't locate `chrome.exe` to auto-launch it, it'll print a warning — but the install itself will still have completed successfully.
- Built for unattended / first-boot scenarios, so it avoids any user-facing installer prompts.

## 📄 License

Free and open source — use, modify, and share it however you'd like.

## ☕ Support

If this saved you some time, consider buying me a coffee:

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-FFDD00?logo=buymeacoffee&logoColor=black)](https://buymeacoffee.com/impxcts)

---

<div align="center">
<sub>Built for the "plug it in and it just works" first-boot workflow.</sub>
</div>
