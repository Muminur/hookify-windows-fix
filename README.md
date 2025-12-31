# Hookify Windows Fix

A simple batch script to fix the [Hookify plugin](https://github.com/anthropics/claude-code) for Claude Code on Windows.

## The Problem

The Hookify plugin for Claude Code uses `python3` command in its hook configurations, which doesn't work on Windows. On Windows, Python is invoked using `python` instead of `python3`.

This causes the following error when using Claude Code with the Hookify plugin:

```
Plugin hook error: 'python3' is not recognized as an internal or external command,
operable program or batch file.
```

## The Solution

This script automatically finds and replaces all `python3` references with `python` in the Hookify plugin's configuration files.

## Requirements

- Windows 10/11
- Python installed and available in PATH (verify with `python --version`)
- Claude Code with Hookify plugin installed

## Installation

### Option 1: Download the Script

1. Download `fix-hookify-python.bat` from this repository
2. Save it anywhere on your computer (e.g., `C:\Users\YourName\`)

### Option 2: Clone the Repository

```bash
git clone https://github.com/YourUsername/hookify-windows-fix.git
cd hookify-windows-fix
```

## Usage

### Run the Fix

1. **Double-click** `fix-hookify-python.bat`
2. The script will automatically:
   - Locate the Hookify plugin cache directory
   - Scan all `hooks.json` files
   - Replace `python3` with `python` where needed
   - Report the results

### Example Output

```
============================================
  Hookify Plugin - Windows Python Fix
============================================

[INFO] Searching for hooks.json files...

[FOUND] C:\Users\Paula\.claude\plugins\cache\...\hooks\hooks.json
[FIXING] Replacing python3 with python...
[SUCCESS] Fixed: C:\Users\Paula\.claude\plugins\cache\...\hooks\hooks.json

============================================
  Fixed 1 file[s] successfully
============================================
```

## When to Run This Script

Run this script:

- After installing the Hookify plugin for the first time
- After the Hookify plugin updates (updates may overwrite the fix)
- Whenever you see the `python3 is not recognized` error

## How It Works

The script:

1. Locates the Hookify plugin cache at:
   ```
   %USERPROFILE%\.claude\plugins\cache\claude-plugins-official\hookify
   ```

2. Recursively finds all `hooks.json` files

3. Uses PowerShell to replace `python3` with `python`:
   ```powershell
   (Get-Content 'file.json') -replace 'python3', 'python' | Set-Content 'file.json'
   ```

4. Reports success/failure for each file

## Troubleshooting

### "Hookify plugin not found"

Make sure:
1. Claude Code is installed
2. The Hookify plugin is enabled in Claude Code settings
3. You've used Claude Code at least once (to initialize the plugin cache)

### Python still not working

Verify Python is installed correctly:
```cmd
python --version
```

If this doesn't work, [install Python](https://www.python.org/downloads/) and make sure to check "Add Python to PATH" during installation.

## License

MIT License - See [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Feel free to:
- Report issues
- Submit pull requests
- Suggest improvements

## Related

- [Claude Code](https://claude.ai/claude-code) - The AI coding assistant
- [Hookify Plugin](https://github.com/anthropics/claude-code) - User-configurable hooks for Claude Code
