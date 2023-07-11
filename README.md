# Space Cadet Pinball (Installer)

## Introduction
As a software developer I've written lots of code before but I wanted to tackle an interesting problem: _"how do I get pinball onto a relatives PC without giving them complex instructions?"_ and thus the idea of writing an installer was born.

### Project Aims, Features and Background
- Single ```.exe``` to install 3D Pinball for Windows – Space Cadet on a modern (Windows 10/11) PC
- K4zmu2a modern SDL-based decompilation executables for both x86 and x86-64 platforms
- Start Menu, Desktop Shortcut, Add/Remove Programs, and an Uninstaller

### Prerequisites & Build Instructions

```powershell
# Build Installer
makensis '.\installer\space-cadet-pinball-installer.nsi'
```

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



