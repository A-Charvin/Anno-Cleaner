# Anno 1800 Autosave Cleaner

A simple AutoHotkey v2 application to automatically clean up old autosave files from Anno 1800, helping you manage disk space and keep your save folders organized.

## ✨ Features

- 🔍 **Auto-detection**: Automatically finds all Anno 1800 save folders
- 🎯 **Smart Selection**: Shows user-friendly folder names instead of long UUID paths
- 🗑️ **Configurable Cleanup**: Keep a specified number of recent autosaves
- 📁 **Manual Browse**: Option to manually select any folder
- 🖥️ **Modern GUI**: Clean, intuitive interface with status feedback
- ⚡ **Fast & Lightweight**: Written in AutoHotkey v2 for minimal resource usage

## 🚀 Quick Start

1. **Download** the latest release or clone this repository
2. **Install** [AutoHotkey v2](https://www.autohotkey.com/download/) if you don't have it
3. **Run** `Anno Cleaner.ahk`
4. **Select** your save folder from the dropdown (auto-detected)
5. **Set** how many autosaves to keep (default: 5)
6. **Click** "Clean Autosaves" to remove old files

## 📋 Requirements

- **Windows** (any version supported by AutoHotkey)
- **AutoHotkey v2.0** or later
- **Anno 1800** installed with save files

## 🎮 How It Works

Anno 1800 creates autosave files in folders like:
```
Documents\Anno 1800\accounts\{uuid}\{Profile Name}\
```

The cleaner:
1. Scans for `.a7s` files recursively
2. Groups them by save folder
3. Sorts by modification time (newest first)
4. Keeps the specified number of recent autosaves
5. Deletes older autosave files

## 🛡️ Safety Features

- **Read-only detection**: Only processes folders containing autosave files
- **Validation checks**: Ensures folder exists before processing
- **Error handling**: Graceful error messages for any issues
- **Preview mode**: Shows how many files will be deleted before action
- **Backup recommendation**: Always backup important saves manually

## 📁 File Structure

```
Anno-1800-Autosave-Cleaner/
├── Anno Cleaner.ahk          # Main application
├── README.md                 # This file
└── LICENSE                   # MIT License
```

## ⚙️ Configuration

The application includes these configurable options:

- **Autosaves to keep**: Number of recent autosave files to preserve (default: 5)
- **Custom folders**: Use the Browse button to select any folder manually
- **Auto-detection**: Automatically scans the default Anno 1800 accounts folder

## 🔧 Advanced Usage

### Command Line
You can modify the script to accept command line parameters for automation:

```batch
"C:\Program Files\AutoHotkey\v2\AutoHotkey.exe" "Anno Cleaner.ahk"
```

### Custom Paths
Edit the `BasePath` variable in the script to change the default search location:

```autohotkey
BasePath := "C:\Custom\Anno1800\Path"
```

## 🐛 Troubleshooting

**No folders detected?**
- Ensure Anno 1800 is installed and you've created some saves
- Check that the default path exists: `Documents\Anno 1800\accounts`

**Permission errors?**
- Run as Administrator if you get file access errors
- Ensure Anno 1800 is not running while cleaning

**Files not being deleted?**
- Verify the folder contains `Autosave*.a7s` files
- Check that files aren't being used by another process

## 🤝 Contributing

Contributions are welcome! Please feel free to:

- Report bugs or issues
- Suggest new features
- Submit pull requests
- Improve documentation

### Development Setup

1. Fork this repository
2. Install AutoHotkey v2
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

This tool deletes files permanently. While it only targets autosave files, always:

- **Backup important saves** before using
- **Test with non-critical saves** first  
- **Use at your own risk**

The authors are not responsible for any data loss.

## 🙏 Acknowledgments

- Anno 1800 community
- AutoHotkey community for documentation and examples
- Blue Byte / Ubisoft for creating Anno 1800

## 📊 Stats

![GitHub release (latest by date)](https://img.shields.io/github/v/release/A-Charvin/Anno-Cleaner)
![GitHub](https://img.shields.io/github/license/A-Charvin/Anno-Cleaner)
![GitHub issues](https://img.shields.io/github/issues/A-Charvin/Anno-Cleaner)

---

**Made with ❤️ for the Anno 1800 community**

*Star ⭐ this repo if it helped you manage your autosaves!*
