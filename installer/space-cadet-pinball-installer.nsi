; Includes
!include "LogicLib.nsh"
!include "x64.nsh"

; Settings -----------------------------------------------------------------------------------
Name "3D Pinball for Windows - Space Cadet"
OutFile "space-cadet-pinball_(v2.0.1)_installer.exe"
RequestExecutionLevel user
Unicode True
RequestExecutionLevel admin
Icon "assets\icon\pinball.ico"
BrandingText "Adam Bonner"

; x86 vs x86-64 Install Dir
Function .onInit

	${If} ${RunningX64}
		StrCpy $INSTDIR "$PROGRAMFILES64\space-cadet-pinball" #64
	${else}
		StrCpy $INSTDIR "$PROGRAMFILES\space-cadet-pinball" #32
	${EndIf}

FunctionEnd

; Pages --------------------------------------------------------------------------------------
Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

; The Stuff to Install -----------------------------------------------------------------------
Section "3D Pinball for Windows - Space Cadet"

	SectionIn RO
	SetOutPath $INSTDIR

	; Add Files from Windows XP, Github .exe x4 Release and Exclude drop.txt
	File /r /x *.txt /x *.sha1 assets\software\Pinball\*.*

	${If} ${RunningX64}
		File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx64Win\*.*
	${else}
		File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx86Win\*.*
	${EndIf}

	; Create Uninstaller
	WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd

; Start Menu Shortcuts -----------------------------------------------------------------------
Section "Start Menu Shortcuts"

	CreateDirectory "$SMPROGRAMS\Space Cadet Pinball"
	CreateShortcut "$SMPROGRAMS\Space Cadet Pinball\3D Pinball for Windows - Space Cadet.lnk" "$INSTDIR\SpaceCadetPinball.exe"
	CreateShortcut "$SMPROGRAMS\Space Cadet Pinball\Uninstall.lnk" "$INSTDIR\uninstall.exe"

SectionEnd

; Uninstaller --------------------------------------------------------------------------------
Section "Uninstall"

	; Remove all files from install directory
	Delete $INSTDIR\*.*

	; Remove shortcuts, if any
	Delete "$SMPROGRAMS\Space Cadet Pinball\*.lnk"

	; Remove directories
	RMDir "$SMPROGRAMS\Space Cadet Pinball"
	RMDir "$INSTDIR"

SectionEnd