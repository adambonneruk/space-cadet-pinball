; Includes
!include "LogicLib.nsh"
!include "x64.nsh"

; Settings
Name "3D Pinball for Windows - Space Cadet"
OutFile "space-cadet-pinball_(v2.0.1)_installer.exe"
RequestExecutionLevel user
Unicode True
RequestExecutionLevel admin
Icon "assets\icon\pinball.ico"
BrandingText "k4zmu2a, adambonneruk"

; x86 vs x86-64 autodetection / install directory
Function .onInit

	${If} ${RunningX64}
		StrCpy $INSTDIR "$PROGRAMFILES64\space-cadet-pinball" ; x86-64
	${else}
		StrCpy $INSTDIR "$PROGRAMFILES\space-cadet-pinball"  ; x86
	${EndIf}

FunctionEnd

; Pages
Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

; Files to map/install
Section "3D Pinball for Windows - Space Cadet"

	SectionIn RO
	SetOutPath $INSTDIR

	; Generic PINBALL.EXE files from Windows XP
	File /r /x *.txt /x *.sha1 assets\software\Pinball\*.*

	; Recompiled/SDL k4zmu2a files (with x86 vs x86-64 autodetection)
	${If} ${RunningX64}
		File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx64Win\*.*
	${else}
		File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx86Win\*.*
	${EndIf}

	; Create Uninstaller
	WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd

; Start Menu Shortcuts
Section "Start Menu Shortcuts"

	CreateDirectory "$SMPROGRAMS\Space Cadet Pinball"
	CreateShortcut "$SMPROGRAMS\Space Cadet Pinball\3D Pinball for Windows - Space Cadet.lnk" "$INSTDIR\SpaceCadetPinball.exe"
	CreateShortcut "$SMPROGRAMS\Space Cadet Pinball\Uninstall.lnk" "$INSTDIR\uninstall.exe"

SectionEnd

; Uninstaller
Section "Uninstall"

	Delete $INSTDIR\*.* ; Remove all files from install directory
	Delete "$SMPROGRAMS\Space Cadet Pinball\*.lnk" ; Remove shortcuts

	; Remove directories
	RMDir "$SMPROGRAMS\Space Cadet Pinball"
	RMDir "$INSTDIR"

SectionEnd