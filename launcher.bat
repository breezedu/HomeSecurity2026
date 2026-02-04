@echo off
REM Home Security Camera System Launcher (Windows)

echo ========================================
echo Home Security Camera System
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH.
    echo Please install Python 3.7 or higher from python.org
    pause
    exit /b 1
)

REM Display Python version
echo Python version:
python --version
echo.

REM Check dependencies
echo Checking dependencies...

python -c "import cv2" >nul 2>&1
if errorlevel 1 (
    echo   X opencv-python NOT installed
    set MISSING_DEPS=1
) else (
    echo   √ opencv-python installed
)

python -c "import PIL" >nul 2>&1
if errorlevel 1 (
    echo   X Pillow NOT installed
    set MISSING_DEPS=1
) else (
    echo   √ Pillow installed
)

python -c "import scapy" >nul 2>&1
if errorlevel 1 (
    echo   X scapy NOT installed
    set MISSING_DEPS=1
) else (
    echo   √ scapy installed
)

python -c "import tkinter" >nul 2>&1
if errorlevel 1 (
    echo   X tkinter NOT installed
    set MISSING_DEPS=1
) else (
    echo   √ tkinter installed
)

if defined MISSING_DEPS (
    echo.
    echo Missing dependencies detected.
    set /p INSTALL="Install missing dependencies? (y/n): "
    if /i "%INSTALL%"=="y" (
        echo Installing dependencies...
        pip install -r requirements.txt
    ) else (
        echo Cannot continue without dependencies.
        pause
        exit /b 1
    )
)

REM Check for camera configuration
if not exist camera_information_mac.json (
    echo.
    echo WARNING: camera_information_mac.json not found!
    echo Please create this file with your camera configuration.
    set /p CONTINUE="Continue anyway? (y/n): "
    if /i not "%CONTINUE%"=="y" exit /b 1
)

REM Create recordings directory
if not exist recorded_videos2026 mkdir recorded_videos2026

echo.
echo Starting application...
echo.
echo NOTE: On Windows, you may need to run this as Administrator
echo       for full network scanning capabilities.
echo.

REM Launch the application
python home_security_ui.py

echo.
echo Application closed.
pause
