; includes
!include "MUI2.nsh"
!include "nsDialogs.nsh"
!include "LogicLib.nsh"
!include "x64.nsh"
!include "FileFunc.nsh"

; defines
!define $PRODUCT_NAME "3D Pinball for Windows - Space Cadet"
!define $APPVERSION "v2.0.1"
!define $PRODUCT_PUBLISHER "Adam Bonner"
!define $ICON_PATH "assets\icon\pinball.ico"
!define $REG_PATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\Space Cadet Pinball"

; compiler options
RequestExecutionLevel admin
SetCompressor /SOLID lzma
Unicode True

; settings
Name "${$PRODUCT_NAME} ${$APPVERSION}"
OutFile "Space Cadet Pinball Installer (${$APPVERSION}).exe"
BrandingText "${$APPVERSION} by k4zmu2a | installer by adambonneruk"

; gui configuration
!define MUI_ICON ${$ICON_PATH}
!define MUI_UNICON ${$ICON_PATH}
!define MUI_ABORTWARNING ; "are you sure you want to quit?" prompt
!define MUI_WELCOMEFINISHPAGE_BITMAP "assets\wizard.bmp"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP ".\assets\header.bmp"
!define MUI_COMPONENTSPAGE_SMALLDESC ; show small description for each component

; mui2 macros/pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "assets\installer-licences.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

;installer sections
Section "Base Game Files (Modern Decompilation)" SecBaseGame ; k4zmu2a's files

	SectionIn RO ; read-only
	SetOutPath $INSTDIR
	RMDIR /r $INSTDIR\*.* ; clean the installation directory
	File ${$ICON_PATH} ; add icon for add/remove programs

	; copy files given x86 or x86-64 operating system
	${If} ${RunningX64}
		File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx64Win\*.*
	${else}
		File /r /x *.txt /x *.sha1 assets\software\SpaceCadetPinballx86Win\*.*
	${EndIf}

	; add uninstaller entry to the add/remove programs control panel
	WriteRegStr HKLM "${$REG_PATH}" "DisplayName" "${$PRODUCT_NAME}"
	WriteRegStr HKLM "${$REG_PATH}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
	WriteRegStr HKLM "${$REG_PATH}" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
	WriteRegStr HKLM "${$REG_PATH}" "DisplayIcon" "$\"$INSTDIR\pinball.ico$\""
	WriteRegStr HKLM "${$REG_PATH}" "DisplayVersion" "${$APPVERSION}"
	WriteRegStr HKLM "${$REG_PATH}" "Publisher" "${$PRODUCT_PUBLISHER}" ; Not show in Windows 10
	WriteRegDWORD HKLM "${$REG_PATH}" "NoModify" 1
	WriteRegDWORD HKLM "${$REG_PATH}" "NoRepair" 1

	; estimate size of installed files for the add/remove programs control panel
	!define ARP "${$REG_PATH}"
	${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
	IntFmt $0 "0x%08X" $0
	WriteRegDWORD HKLM "${ARP}" "EstimatedSize" "$0"

	; create uninstaller
	WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd

Section "${$PRODUCT_NAME}" secPinball ; windows xp pinball.exe files

	SectionIn RO ; read-only
	File /r /x *.txt /x *.sha1 assets\software\Pinball\*.* ; copy pinball.exe's files

SectionEnd

Section /o "Full Tilt! Pinball files" secFullTilt ; full tilt pinball file ; /o == unchecked

	File /nonfatal /r /x *.txt /x *.sha1 assets\software\CADET\*.* ; copy full tile files ; optional

SectionEnd

Section "Start Menu Shortcuts" SecStartMenu

	CreateDirectory "$SMPROGRAMS\Space Cadet Pinball"
	CreateShortcut "$SMPROGRAMS\Space Cadet Pinball\${$PRODUCT_NAME}.lnk" "$INSTDIR\SpaceCadetPinball.exe"
	CreateShortcut "$SMPROGRAMS\Space Cadet Pinball\Uninstall.lnk" "$INSTDIR\uninstall.exe"

SectionEnd

Section "Desktop Shortcut" SecDeskShort

	CreateShortcut "$DESKTOP\${$PRODUCT_NAME}.lnk" "$INSTDIR\SpaceCadetPinball.exe" "" "$INSTDIR\pinball.ico" 0

SectionEnd

Function .onInit

	; set install folder given x86 or x86-64 operating system
	${If} ${RunningX64}
		StrCpy $INSTDIR "$PROGRAMFILES64\Space Cadet Pinball"
		SetRegView 64
	${else}
		StrCpy $INSTDIR "$PROGRAMFILES\Space Cadet Pinball"
		SetRegView 32
	${EndIf}

FunctionEnd

; component descriptions
LangString DESC_SecSCP ${LANG_ENGLISH} 			"Install K4zmu2a's decompilation base game, includes 32/64-bit auto-detection"
LangString DESC_SecPinball ${LANG_ENGLISH} 		"Install the classic pinball game included with older versions of Windows"
LangString DESC_SecFullTilt ${LANG_ENGLISH} 	"Install Full Tilt! Pinball with high-resolution textures and advanced gameplay features"
LangString DESC_SecStartMenu ${LANG_ENGLISH} 	"Install Windows Start Menu shortcuts"
LangString DESC_SecDeskShort ${LANG_ENGLISH} 	"Install Windows desktop shortcut"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecSCP} $(DESC_SecSCP)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecPinball} $(DESC_SecPinball)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecFullTilt} $(DESC_SecFullTilt)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecStartMenu} $(DESC_SecStartMenu)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDeskShort} $(DESC_SecDeskShort)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; configure uninstaller
Section "Uninstall"

	RMDIR /r $INSTDIR\*.* ; clean the installation directory
	Delete "$DESKTOP\${$PRODUCT_NAME}.lnk" ; delete desktop shortcut
	DeleteRegKey HKLM "${$REG_PATH}" ; delete windows add/remove programs key

	; remove start menu shortcuts
	Delete "$SMPROGRAMS\Space Cadet Pinball\*.lnk"
	RMDir "$SMPROGRAMS\Space Cadet Pinball"

SectionEnd
