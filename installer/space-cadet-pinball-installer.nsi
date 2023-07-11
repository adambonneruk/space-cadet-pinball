; Settings -----------------------------------------------------------------------------------
Name "3D Pinball for Windows - Space Cadet"
OutFile "space-cadet-pinball_(v2.0.1)_installer_x64.exe"
RequestExecutionLevel user
InstallDir "$PROGRAMFILES64\space-cadet-pinball"
Unicode True
RequestExecutionLevel admin

; Pages --------------------------------------------------------------------------------------
Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

; The Stuff to Install -----------------------------------------------------------------------
Section "3D Pinball for Windows - Space Cadet (Required)"

	SectionIn RO
	SetOutPath $INSTDIR

	; Add Files from Windows XP, Github .exe x4 Release and Exlude drop.txt
	File /r /x *.txt /x *.sha1 assets\software\Pinball\*.*
	File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx64Win\*.*

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