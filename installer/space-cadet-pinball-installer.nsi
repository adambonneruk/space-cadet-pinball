; Includes
!include "MUI2.nsh"
!include "nsDialogs.nsh"
!include "LogicLib.nsh"
!include "x64.nsh"
!include "FileFunc.nsh"

; Settings
!define $0 "v2.0.1"		; $0 is Version Number
Name "3D Pinball for Windows - Space Cadet ${$0}"
OutFile "Space Cadet Pinball Installer (${$0}).exe"
BrandingText "${$0} by k4zmu2a | Copyright Maxis 1995, Microsoft 2007 | Installer by adambonneruk"
RequestExecutionLevel admin
Unicode True
SetCompressor /SOLID lzma	; This reduces installer size by approx 30~35%

; Modern interface settings
!define MUI_ICON "assets\icon\pinball.ico"
!define MUI_UNICON "assets\icon\pinball.ico"
!define MUI_ABORTWARNING
!define MUI_WELCOMEFINISHPAGE_BITMAP "assets\wizard.bmp"
!define MUI_HEADERIMAGE_BITMAP ".\graphics\headerLeft.bmp" ; optional
!define MUI_HEADERIMAGE_BITMAP_RTL ".\graphics\headerLeft_RTL.bmp" ; Header for RTL languages
!define MUI_COMPONENTSPAGE_SMALLDESC ;Show components page with a small description and big box for components

; x86 vs x86-64 autodetection / install directory
Function .onInit

	${If} ${RunningX64}
		StrCpy $INSTDIR "$PROGRAMFILES64\Space Cadet Pinball" ; x86-64
	${else}
		StrCpy $INSTDIR "$PROGRAMFILES\Space Cadet Pinball"  ; x86
	${EndIf}

FunctionEnd

; Pages (as MUI2 Macros)
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "assets\installer-licences.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

;Installer Sections
Section "3D Pinball for Windows - Space Cadet" SecSCP

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
Section "Start Menu Shortcuts" SecStartMenu

	CreateDirectory "$SMPROGRAMS\Space Cadet Pinball"
	CreateShortcut "$SMPROGRAMS\Space Cadet Pinball\3D Pinball for Windows - Space Cadet.lnk" "$INSTDIR\SpaceCadetPinball.exe"
	CreateShortcut "$SMPROGRAMS\Space Cadet Pinball\Uninstall.lnk" "$INSTDIR\uninstall.exe"

SectionEnd

; Desktop Shortcut
Section "Desktop Shortcut" SecDeskShort

	CreateShortcut "$DESKTOP\3D Pinball for Windows - Space Cadet.lnk" "$INSTDIR\SpaceCadetPinball.exe" "" "$INSTDIR\pinball.ico" 0

SectionEnd

;Descriptions
;Language strings
LangString DESC_SecSCP ${LANG_ENGLISH} 			"Install the base game, Kk4zmu2a's decompilation version, includes 32/64-bit auto-detection"
LangString DESC_SecStartMenu ${LANG_ENGLISH} 	"Install Windows Start Menu shortcuts"
LangString DESC_SecDeskShort ${LANG_ENGLISH} 	"Install Windows desktop shortcut"

;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecSCP} $(DESC_SecSCP)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecStartMenu} $(DESC_SecStartMenu)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDeskShort} $(DESC_SecDeskShort)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;Uninstaller Section
Section "Uninstall"

	Delete $INSTDIR\*.* ; Remove all files from install directory
	Delete "$SMPROGRAMS\Space Cadet Pinball\*.lnk" ; Remove shortcuts
	Delete "$DESKTOP\3D Pinball for Windows - Space Cadet.lnk" ; Remove desktop shortcut

	; Remove directories
	RMDir "$SMPROGRAMS\Space Cadet Pinball"
	RMDir "$INSTDIR"

	; Remove Windows Add/Remove Programs Entry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SpaceCadetPinball"

SectionEnd
