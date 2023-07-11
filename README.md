# Space Cadet Pinball (Installer)

## Introduction
As a software developer I've written lots of code before but I wanted to tackle an interesting problem: _"how do I get pinball onto a relatives PC without giving them complex instructions?"_ and thus the idea of writing an installer was born.

### Project Aims, Features and Background
- Single ```.exe``` to install 3D Pinball for Windows on a modern (Windows 10/11) PC
- K4zmu2a modern SDL-based executables for both x86 and x86-64 platforms
- Start Menu, Desktop Shortcut, Add/Remove Programs, and an Uninstaller

### Prerequisites & Build Instructions

#### 1. NSIS (Nullsoft Scriptable Install System)
- [Download NSIS](https://nsis.sourceforge.io/Download) from Sourceforge (currently [v3.08](https://prdownloads.sourceforge.net/nsis/nsis-3.08-setup.exe?download))
- Add NSIS (Specifically ```makensis.exe``` to system ```PATH```)

#### 2. Windows XP's ```PINBALL.EXE``` files
- Available from the [Internet Archive](https://archive.org/details/3d-pinball-space-cadet_202103), download, unpack and locate/move using PowerShell:

  ```powershell
  # Download, Unpack, and Place PINBALL.EXE Files (with Clean-Up)
  Invoke-WebRequest -Uri 'https://archive.org/download/3d-pinball-space-cadet_202103/3D%20Pinball%20Space%20Cadet.zip' -OutFile '3DPinballSpaceCadet.zip' ; Expand-Archive '3DPinballSpaceCadet.zip' xp-files ; xcopy 'xp-files\3D Pinball Space Cadet' 'software\Pinball' ; rm -rf '3DPinballSpaceCadet.zip' ; rm -rf 'xp-files'
  ```

- Verify checksums

  ```powershell
  start '.\software\Pinball\checksum.sha1'
  ```

### 3. Latest  [k4zmu2a/SpaceCadetPinball](https://github.com/k4zmu2a/SpaceCadetPinball/releases) release (currently [v2.0.1](https://github.com/k4zmu2a/SpaceCadetPinball/releases/tag/Release_2.0.1))

  > __Note__: Installer requires both x32/x86 and x64/x86-64 decompilations to be stored in _software_ folder correctly

- Download and unpack using PowerShell:

  ```powershell
  # Download, Unpack, and Place x86-64 k4zmu2a Files (with Clean-Up)
  Invoke-WebRequest -Uri 'https://github.com/k4zmu2a/SpaceCadetPinball/releases/download/Release_2.0.1/SpaceCadetPinballx64Win.zip' -OutFile 'SpaceCadetPinballx64Win.zip' ; Expand-Archive 'SpaceCadetPinballx64Win.zip' '.\software\SpaceCadetPinballx64Win\' ; rm -rf 'SpaceCadetPinballx64Win.zip'

  # Download, Unpack, and Place x86 k4zmu2a Files (with Clean-Up)
  Invoke-WebRequest -Uri 'https://github.com/k4zmu2a/SpaceCadetPinball/releases/download/Release_2.0.1/SpaceCadetPinballx86Win.zip' -OutFile 'SpaceCadetPinballx86Win.zip' ; Expand-Archive 'SpaceCadetPinballx86Win.zip' '.\software\SpaceCadetPinballx86Win\' ; rm -rf 'SpaceCadetPinballx86Win.zip'
  ```

- Verify checksums

  ```powershell
  start '.\software\SpaceCadetPinballx64Win\checksum.sha1'
  start '.\software\SpaceCadetPinballx86Win\checksum.sha1'
  ```

### 4. ___Optional__:_ Full Tilt! Pinball - Space Cadet Files

  > __Note__: Installer will compile without these files with a graceful warning: ```1 warning: 7010: File: "software\CADET\*.*" -> no files found. (.\space-cadet-pinball.nsi:83)```. This is expected behaviour as these files are not on the open internet

- Download and unpack to ```./Software/CADET/```:
- Verify checksums

  ```powershell
  start '.\software\CADET\checksum.sha1'
  ```

### 5. Check project structure
- Folder structure should resemble the following ```tree```:

  ```
  tree here
  ```

### 6. Create the installer using _makensis_
- Execute makensis
  ```powershell
  # Build Installer
  makensis '.\installer\space-cadet-pinball-installer.nsi'
  ```
- .exe is created in the ```installer``` (.nsi) directory
- double click to install...

  ![](.images/installer-demo-1-welcome.png)









































































## 3D Pinball for Windows - Space Cadet: A History

| ![](.images/windows-xp.jpg) |  ![](.images/windows-ten.jpg)   |
| :-------------------------: | :-----------------------------: |
| The original on Windows XP  | K4zmu2a's version on Windows 10 |

### Windows 95, Full Tilt! and Windows XP

<img align="right" src=".images/logo-3dpfw.jpg" />

_3D Pinball for Windows – Space Cadet_ was a pinball video game that was included with Windows XP. The game quickly became a favourite among Windows users and provided a fun and entertaining experience right on their desktops. The development of _3D Pinball for Windows_ can be traced back to the 1990s when Microsoft partnered with Cinematronics; a pinball manufacturer, and Maxis to create a pinball game for _Microsoft Plus! for Windows 95_.

"Full Tilt! Pinball" is a pinball video game developed by Cinematronics and published by Maxis. It features multiple themed pinball tables with immersive gameplay, including realistic physics, interactive elements, and challenging missions. Known for its engaging gameplay and captivating visuals, "Full Tilt! Pinball" offers a diverse pinball experience with various table designs and objectives.

<img align="right" src=".images/logo-ftp.jpg" />

Maxis released Full Tilt! Pinball for Windows 98. This enhanced version of the "Space Cadet" pinball game came with two new tables (Skullduggery and Dragon's Keep) and included new missions and functionality not available in the "stock" Windows versions.

[David Plummer](https://github.com/davepl) while working at Microsoft ported the code to Windows XP but modern UI developments, the 64-bit shell, combined with time pressures releasing the new Windows Vista operating system confined Pinball to the recycle bin from that release forward. ```Pinball.exe``` (the name of the _3D Pinball for Windows – Space Cadet_ executable) still works with modern (even 64-bit) versions of Windows but this code starts to look dated when viewed through a 2023 lens.

### k4zmu2a/SpaceCadetPinball
Enter K4zmu2a, who's decompilation project provides access to the game's source code and assets, allowing developers to understand how the game functions and potentially modify or enhance it. K4zmu2a has made a number of improvements, including the ability to load high-resolution textures from _Full Tilt!_ and allowing the game windows to be resized. This project uses SDL aiding portability across platforms, including Windows 10 x86 and x86-64 platforms. For detailed instructions on how to use and integrate this decompiled version of 3D Pinball for Windows into your own projects, please refer to the documentation provided by [K4zmu2a](https://github.com/k4zmu2a).

---
## Copyright Notice(s)
- Screenshots/Images are used under "fair use" guidelines
- Compiled software is utilised as made available in the Public Domain, including GitHub and the Internet Archive project. All rights reserved by their respective copyright holders:
  - Microsoft
  - Maxis
  - Cinematronics
  - K4zmu2a

---
## Contributing to this Project
This project welcomes contributions of all types. We ask that before you start work on a feature that you would like to contribute, please read the [Contributor's Guide](.github/CONTRIBUTING.md).

---
## Security Policy for this Project
This project seeks to build secure, versatile and robust portable software. If you find an issue, please report it following the [Security Policy](.github/SECURITY.md)

---
## Thanks & Useful Links

#### People
- Andrey Muzychenko ([k4zmu2a](https://github.com/k4zmu2a)) for their great decompilation / pinball reverse-engineering project and binaries
- David Plummer ([davepl](https://github.com/davepl)) for their YouTube channel and porting 3D Pinball to Windows XP all those years ago

#### Software
- The [NSIS](https://nsis.sourceforge.io/Main_Page) Project
- [Paint.net](https://getpaint.net/) for Image editing
- [IcoFx Portable](https://portableapps.com/apps/graphics_pictures/icofx_portable) for Icon file editing

#### Further Reading
- [Full Tilt! Pinball](https://en.wikipedia.org/wiki/Full_Tilt!_Pinball) on Wikipedia
- [Microsoft Plus!](https://en.wikipedia.org/wiki/Microsoft_Plus!) on Wikipedia


#### Online Useful Links/Guides
- Notepad++'s NSIS Source Code: https://github.com/notepad-plus-plus/notepad-plus-plus/tree/master/PowerEditor/installer
- Estimating install directory size: https://nsis.sourceforge.io/Add_uninstall_information_to_Add/Remove_Programs
- Accessing the 64-bit (non-wow) version of the Registry: https://stackoverflow.com/questions/50649571/how-to-force-readregstr-to-read-32bit-node
- Override desktop shortcut icon: https://stackoverflow.com/questions/9317007/how-to-create-an-icon-shortcut-with-nsis#9318296
- Merging x86 and x86-64 into one installer example: https://stackoverflow.com/questions/21822044/merge-32bit-and-64bit-installer-into-one-installer-using-nsis#21823968
- x86-64 program files: https://nsis.sourceforge.io/Reference/$PROGRAMFILES