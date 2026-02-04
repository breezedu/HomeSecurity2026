#!/bin/bash

# Home Security Camera System Launcher
# This script checks dependencies and launches the application

echo "========================================"
echo "Home Security Camera System"
echo "========================================"
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed."
    echo "Please install Python 3.7 or higher."
    exit 1
fi

# Check Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "Python version: $PYTHON_VERSION"

# Check if running with sudo (needed for ARP scanning)
if [ "$EUID" -ne 0 ]; then 
    echo ""
    echo "WARNING: This application requires root privileges for ARP scanning."
    echo "Please run with sudo:"
    echo "  sudo ./launcher.sh"
    echo ""
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check dependencies
echo ""
echo "Checking dependencies..."

check_package() {
    python3 -c "import $1" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "  ✓ $1 installed"
        return 0
    else
        echo "  ✗ $1 NOT installed"
        return 1
    fi
}

MISSING_DEPS=0

check_package "cv2" || MISSING_DEPS=1
check_package "PIL" || MISSING_DEPS=1
check_package "scapy" || MISSING_DEPS=1
check_package "tkinter" || MISSING_DEPS=1

if [ $MISSING_DEPS -eq 1 ]; then
    echo ""
    echo "Missing dependencies detected."
    read -p "Install missing dependencies? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing dependencies..."
        pip3 install -r requirements.txt
    else
        echo "Cannot continue without dependencies."
        exit 1
    fi
fi

# Check for camera configuration file
if [ ! -f "camera_information_mac.json" ]; then
    echo ""
    echo "WARNING: camera_information_mac.json not found!"
    echo "Please create this file with your camera configuration."
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create recordings directory if it doesn't exist
mkdir -p recorded_videos2026

echo ""
echo "Starting application..."
echo ""

# Launch the application
python3 home_security_ui.py

echo ""
echo "Application closed."
