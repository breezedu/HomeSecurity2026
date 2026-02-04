# Quick Start Guide - Home Security Camera System

## 5-Minute Setup

### Step 1: Install Dependencies (First Time Only)

**Linux/macOS:**
```bash
sudo pip3 install opencv-python pillow scapy
```

**Windows:**
```cmd
pip install opencv-python pillow scapy
```

### Step 2: Configure Your Cameras

Edit `camera_information_mac.json`:

```json
[
  {
    "Name": "frontdoor",
    "mac": "AA:BB:CC:DD:EE:01",
    "username": "admin",
    "Password": "your_camera_password",
    "ip": "192.168.1.100",
    "stream": "stream1"
  }
]
```

**Finding your camera information:**
- **IP Address**: Check your router's DHCP table
- **MAC Address**: Found on camera label or router
- **Username/Password**: Camera admin credentials
- **Stream**: Usually "stream1" (main) or "stream2" (sub)

### Step 3: Test Camera Connection

Test with VLC or ffplay:
```bash
ffplay rtsp://username:password@192.168.1.100/stream1
```

### Step 4: Run the Application

**Linux/macOS:**
```bash
sudo ./launcher.sh
```

**Windows (as Administrator):**
```cmd
launcher.bat
```

Or directly:
```bash
sudo python3 home_security_ui.py  # Linux/macOS
python home_security_ui.py        # Windows
```

### Step 5: Start Recording

1. Click **▶ Start Recording** button
2. Watch status indicators turn green
3. Check **Logs** tab for any errors
4. Recordings save to `recorded_videos2026/YYYY-MM-DD/`

## Common Issues & Quick Fixes

### "Could not find IP for camera"
- ✓ Run with sudo/admin privileges
- ✓ Verify MAC address is correct
- ✓ Camera is on same network

### "Could not open camera"
- ✓ Test RTSP URL in VLC
- ✓ Check username/password
- ✓ Verify camera stream path
- ✓ Check firewall settings

### "No preview showing"
- ✓ Normal - preview appears after recording starts
- ✓ Check Logs tab for errors

### Camera keeps disconnecting
- ✓ Check network stability
- ✓ Verify camera power supply
- ✓ Try sub-stream (stream2) for stability

## Tips for Best Results

1. **Start with one camera** - Test with a single camera first
2. **Use static IPs** - Assign static IPs to cameras in router
3. **Test RTSP URLs** - Always test with VLC before adding to app
4. **Monitor logs** - Keep Logs tab open when starting
5. **Check disk space** - Ensure enough storage (videos are large)

## Default Settings

- **Recording Duration**: 30 minutes per video file
- **Storage Location**: `./recorded_videos2026/`
- **Cleanup Policy**: Auto-delete after 3 weeks
- **Network Scan Range**: 192.168.1.0/24

Change these in: **File → Settings**

## File Locations

```
recorded_videos2026/
  └── 2026-02-03/
      ├── frontdoor_20260203_140530.mp4
      ├── backyard_20260203_140530.mp4
      └── garage_20260203_140530.mp4
```

## Getting Help

1. Check **Logs** tab in application
2. Review README.md for detailed troubleshooting
3. Test camera with VLC: `rtsp://user:pass@ip/stream1`
4. Verify network connectivity: `ping camera_ip`

## Next Steps

After successful first recording:
- Add more cameras via **Cameras → Add Camera**
- Adjust settings via **File → Settings**
- Browse recordings in **Recordings** tab
- Set up as system service for automatic startup

## Example Working Configuration

```json
[
  {
    "Name": "garage",
    "mac": "A1:B2:C3:D4:E5:F6",
    "username": "admin",
    "Password": "MySecurePass123",
    "ip": "192.168.1.168",
    "stream": "stream1"
  }
]
```

**RTSP URL Generated:**
```
rtsp://admin:MySecurePass123@192.168.1.168/stream1
```

---

**Ready to start? Run the launcher script and click Start Recording!** 🎥
