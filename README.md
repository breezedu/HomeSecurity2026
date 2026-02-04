# Home Security Camera System - UI Application

A modern GUI application for managing and recording from multiple IP security cameras with automatic MAC-to-IP resolution, live monitoring, and automated storage management.

## Features

### 🎥 Camera Management
- **Multi-camera support**: Monitor and record from unlimited cameras simultaneously
- **Dynamic IP resolution**: Automatically find cameras by MAC address using ARP
- **Live preview**: See thumbnail previews from each camera while recording
- **Camera CRUD**: Add, edit, and delete cameras through the UI

### 📹 Recording Capabilities
- **Continuous recording**: 30-minute video segments (configurable)
- **Multi-threaded**: Each camera records independently
- **Auto-recovery**: Automatic reconnection if a camera goes offline
- **Date-organized storage**: Videos organized in daily folders (YYYY-MM-DD)
- **Automatic cleanup**: Deletes recordings older than 3 weeks

### 💻 User Interface
- **Camera Monitor Tab**: Visual grid showing all cameras with live previews and status
- **Logs Tab**: Real-time logging of all system events
- **Recordings Tab**: Browse and manage recorded videos
- **Control Panel**: Start/Stop recording with one click
- **Settings Dialog**: Configure recording duration, storage location, and network settings

### 🛡️ Reliability Features
- **Thread-safe**: Proper threading for concurrent camera operations
- **Error handling**: Graceful handling of network issues and camera failures
- **Status indicators**: Real-time status for each camera (Idle, Connecting, Recording, Error)
- **Persistent configuration**: Camera settings saved in JSON format

## Requirements

### System Requirements
- Python 3.7 or higher
- Linux, macOS, or Windows
- Network access to IP cameras
- Root/Admin privileges (for ARP scanning)

### Python Dependencies
```bash
pip install opencv-python opencv-contrib-python
pip install pillow
pip install scapy
```

### Additional System Dependencies

#### Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install python3-tk
sudo apt-get install libopencv-dev python3-opencv
sudo apt-get install ffmpeg
```

#### macOS
```bash
brew install python-tk
brew install opencv
brew install ffmpeg
```

#### Windows
- Install Python with Tkinter (included in standard Python installer)
- OpenCV and FFmpeg will be installed via pip

## Installation

1. **Clone or download the application files:**
```bash
git clone <repository-url>
cd home-security-ui
```

2. **Install Python dependencies:**
```bash
pip install -r requirements.txt
```

Or manually:
```bash
pip install opencv-python pillow scapy
```

3. **Verify Tkinter installation:**
```bash
python -c "import tkinter; print('Tkinter is installed')"
```

4. **Configure camera information:**
   - Edit `camera_information_mac.json` with your camera details
   - See Configuration section below

## Configuration

### Camera Configuration File: `camera_information_mac.json`

The application uses a JSON file to store camera configurations. Each camera entry should include:

```json
[
  {
    "Name": "garagecamera",
    "mac": "AA:BB:CC:DD:EE:01",
    "username": "admin",
    "Password": "your_password",
    "ip": "192.168.1.168",
    "stream": "stream1"
  }
]
```

**Field Descriptions:**
- `Name`: Friendly name for the camera (required)
- `mac`: MAC address for dynamic IP resolution (required if IP changes)
- `username`: Camera login username (required)
- `Password`: Camera login password (required)
- `ip`: Static IP address (optional if using MAC)
- `stream`: RTSP stream path (typically "stream1" or "stream2")

### Camera Requirements

Your IP cameras must support:
- **RTSP protocol** for video streaming
- **Authentication** via username/password
- **H.264 codec** (recommended for compatibility)

### RTSP URL Format

The application constructs RTSP URLs as:
```
rtsp://username:password@ip_address/stream_path
```

Common stream paths:
- `stream1` - Main stream (high quality)
- `stream2` - Sub stream (lower quality)
- `h264` - Some cameras use this
- `live/ch00_0` - Hikvision format

## Usage

### Starting the Application

#### Linux/macOS (requires sudo for ARP scanning):
```bash
sudo python3 home_security_ui.py
```

#### Windows (run as Administrator):
```bash
python home_security_ui.py
```

### Main Interface

#### Control Panel
- **▶ Start Recording**: Begin recording from all cameras
- **⏹ Stop Recording**: Stop all recordings
- **🔄 Refresh Cameras**: Reload camera configuration
- **Status indicator**: Shows current system state

#### Camera Monitor Tab
- Displays a grid of all configured cameras
- Shows live preview thumbnails during recording
- Color-coded status indicators:
  - **Gray (● Idle)**: Camera not recording
  - **Orange (● Connecting...)**: Attempting to connect
  - **Green (● Recording)**: Successfully recording
  - **Red (● Error)**: Connection or recording error

#### Logs Tab
- Real-time log of all system events
- Timestamps for all activities
- Error messages and debugging information

#### Recordings Tab
- Tree view of all recorded videos organized by date
- Shows camera name, timestamp, and file size
- **Open Recordings Folder**: Open file browser to recordings
- **Refresh List**: Update the recordings display

### Menu Options

#### File Menu
- **Settings**: Configure recording parameters
  - Video duration (default: 30 minutes)
  - Recording directory (default: ./recorded_videos2026)
  - Network range for IP scanning (default: 192.168.1.0/24)
- **Exit**: Close the application

#### Cameras Menu
- **Add Camera**: Add a new camera to the system
- **Edit Camera**: Modify camera settings
- **Delete Camera**: Remove a camera from the system

## File Structure

```
home-security-ui/
├── home_security_ui.py              # Main application
├── camera_information_mac.json       # Camera configuration
├── recorded_videos2026/              # Default recording directory
│   ├── 2026-02-03/                  # Date-based folders
│   │   ├── garagecamera_20260203_140530.mp4
│   │   ├── backyardcamera_20260203_140530.mp4
│   │   └── livingroomcamera_20260203_140530.mp4
│   └── 2026-02-04/
└── README.md                         # This file
```

## Troubleshooting

### Camera Not Connecting

1. **Check IP address**: Verify camera is reachable
   ```bash
   ping 192.168.1.168
   ```

2. **Test RTSP stream**: Use VLC or ffplay
   ```bash
   ffplay rtsp://username:password@192.168.1.168/stream1
   ```

3. **Verify credentials**: Ensure username/password are correct

4. **Check firewall**: Ensure RTSP port (554) is not blocked

### MAC Address Not Resolving to IP

1. **Check network range**: Verify the network range in settings matches your network
2. **Run with proper privileges**: ARP scanning requires root/admin access
3. **Check ARP table**: 
   ```bash
   arp -a
   ```

### Application Won't Start

1. **Check Python version**: Must be 3.7 or higher
   ```bash
   python3 --version
   ```

2. **Verify dependencies**:
   ```bash
   pip list | grep -E "opencv|pillow|scapy"
   ```

3. **Check Tkinter**:
   ```bash
   python3 -c "import tkinter"
   ```

### Recording Issues

1. **Check disk space**: Ensure sufficient storage
2. **Verify write permissions**: Application must have write access to recording directory
3. **Review logs**: Check the Logs tab for error messages
4. **Test codec**: Some systems may need different codecs:
   ```python
   # In code, try changing:
   fourcc = cv2.VideoWriter_fourcc(*'mp4v')
   # to:
   fourcc = cv2.VideoWriter_fourcc(*'H264')
   ```

### Performance Issues

1. **Reduce camera count**: Test with fewer cameras
2. **Lower resolution**: Use sub-stream (stream2) instead of main stream
3. **Increase hardware resources**: More RAM/CPU may be needed
4. **Check network bandwidth**: Ensure sufficient network capacity

## Advanced Configuration

### Custom Video Duration

Edit in Settings or modify `config` in code:
```python
"video_duration": 30 * 60,  # 30 minutes in seconds
```

### Custom Cleanup Period

Modify in code (default is 3 weeks):
```python
three_weeks_ago = now - (3 * 7 * 24 * 60 * 60)
```

### Different Video Codec

For better compression, modify in code:
```python
fourcc = cv2.VideoWriter_fourcc(*'H264')  # or 'XVID', 'MJPG'
```

### Network Range for Multiple Subnets

If cameras span multiple subnets, modify `find_ip_by_mac`:
```python
network_ranges = ["192.168.1.0/24", "192.168.2.0/24"]
for network_range in network_ranges:
    # ... scan each range
```

## Security Considerations

1. **Credentials Storage**: Passwords are stored in plain text in the JSON file
   - Keep configuration file secure
   - Consider encrypting the JSON file
   - Use strong, unique passwords

2. **Network Security**: 
   - Use VLANs to isolate camera network
   - Enable HTTPS on cameras if available
   - Use strong RTSP passwords

3. **File Permissions**:
   - Restrict access to recording directory
   - Regular backup of recordings

## Performance Optimization

### For Multiple Cameras (5+):
- Use sub-streams instead of main streams
- Reduce FPS in camera settings
- Use hardware-accelerated encoding if available
- Consider dedicated recording hardware

### For Low-End Hardware:
- Reduce video duration segments
- Use lower resolution streams
- Disable preview updates or reduce frequency
- Record to SSD instead of HDD

## Future Enhancements

Potential features for future versions:
- [ ] Motion detection and alerts
- [ ] Remote viewing via web interface
- [ ] Cloud backup integration
- [ ] Email/SMS notifications
- [ ] Encrypted credential storage
- [ ] Multiple user accounts
- [ ] Mobile app companion
- [ ] AI-based event detection
- [ ] Export to different video formats
- [ ] Playback within the application

## License

This application is provided as-is for personal and educational use.

## Support

For issues, questions, or contributions:
1. Check the Troubleshooting section above
2. Review application logs in the Logs tab
3. Ensure all requirements are met
4. Test with a single camera first

## Credits

Built with:
- Python 3.x
- OpenCV for video processing
- Tkinter for GUI
- Scapy for network operations
- PIL for image handling

---

**Note**: Always ensure you have proper authorization to record video on your property and comply with local privacy laws.
