# -*- mode: python ; coding: utf-8 -*-

block_cipher = None

# Analysis: Specify what to include and exclude
a = Analysis(
    ['home_security_ui.py'],
    pathex=[],
    binaries=[],
    datas=[
        ('camera_information_mac.json', '.'),  # Include config file
    ],
    hiddenimports=[
        'cv2',
        'PIL',
        'PIL._tkinter_finder',
        'scapy.all',
        'tkinter',
        'threading',
        'json',
        'datetime',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[
        'matplotlib',  # Exclude matplotlib
        'pandas',      # Exclude pandas
        'scipy',       # Exclude scipy
        'numpy.random._examples',  # Exclude unnecessary numpy modules
    ],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='HomeSecurityApp',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,  # Set to False for GUI app (no console window)
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=None,  # Add icon='icon.ico' if you have an icon file
)
