@echo off
setlocal enabledelayedexpansion

echo ============================================
echo   Hookify Plugin - Windows Python Fix
echo ============================================
echo.

set "PLUGIN_DIR=%USERPROFILE%\.claude\plugins\cache\claude-plugins-official\hookify"

if not exist "%PLUGIN_DIR%" (
    echo [ERROR] Hookify plugin not found at:
    echo         %PLUGIN_DIR%
    echo.
    echo Make sure the hookify plugin is installed in Claude Code.
    pause
    exit /b 1
)

echo [INFO] Searching for hooks.json files...
echo.

set "FIXED=0"

for /r "%PLUGIN_DIR%" %%f in (hooks.json) do (
    echo [FOUND] %%f

    REM Check if file contains python3
    findstr /c:"python3" "%%f" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [FIXING] Replacing python3 with python...

        REM Create temp file with replacement
        powershell -Command "(Get-Content '%%f') -replace 'python3', 'python' | Set-Content '%%f'"

        if !errorlevel! equ 0 (
            echo [SUCCESS] Fixed: %%f
            set /a FIXED+=1
        ) else (
            echo [ERROR] Failed to fix: %%f
        )
    ) else (
        echo [OK] Already using python - no fix needed
    )
    echo.
)

echo ============================================
if !FIXED! gtr 0 (
    echo   Fixed !FIXED! file[s] successfully
) else (
    echo   No files needed fixing
)
echo ============================================
echo.
pause
