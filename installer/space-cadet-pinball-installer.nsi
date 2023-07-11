; Includes
!include "LogicLib.nsh"
!include "x64.nsh"
!include "FileFunc.nsh"

; Settings
Name "3D Pinball for Windows - Space Cadet"
OutFile "space-cadet-pinball_(v2.0.1)_installer.exe"
Unicode True
RequestExecutionLevel admin
Icon "assets\icon\pinball.ico"
BrandingText "v2.0.1 (installer v3): k4zmu2a"
SetCompressor /SOLID lzma ; This reduces installer size by approx 30~35%

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
	File "assets\icon\pinball.ico" ; add icon for add/remove programs

	; Recompiled/SDL k4zmu2a files (with x86 vs x86-64 autodetection)
	${If} ${RunningX64}
		File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx64Win\*.*
	${else}
		File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx86Win\*.*
	${EndIf}

	; Add Uninstaller Entry to Add/Remove Programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball" "DisplayName" "3D Pinball for Windows - Space Cadet"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball" "DisplayIcon" "$\"$INSTDIR\pinball.ico$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball" "DisplayVersion" "v2.0.1"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball" "Publisher" "adambonneruk" ; Win 10 not showing this
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball" "NoRepair" 1

	; Get Installed Size for use in Estimated Size in Windows Add/Remove Programs
	!define ARP "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball"
	${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
	IntFmt $0 "0x%08X" $0
	WriteRegDWORD HKLM "${ARP}" "EstimatedSize" "$0"

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

	; Remove Windows Add/Remove Programs Entry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball"

SectionEnd