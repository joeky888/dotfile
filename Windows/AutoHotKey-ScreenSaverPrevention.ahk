#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode RegEx ;http://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm
;jfrmilner hotkeys
;^ = Ctrl, ! = ALT, # = Win
#Include %A_ScriptDir%
;autoexecute section
preventScreenSaverVar := true ; Boolean for Screen-saver prevention label (subroutine). True = running/enabled.
SetTimer, preventScreenSaver, 60000 ; Screen-saver launch prevention label (subroutine), checks every 1 minute


^5::
global preventScreenSaverVar := !preventScreenSaverVar
if (global preventScreenSaverVar) {
TrayTip, Screen Saver Prevention, Enabled, 2, 17
}
else { TrayTip, Screen Saver Prevention, Disabled, 2, 17
}
return

;ScreenSaver launch prevention subroutine
preventScreenSaver:
if (global preventScreenSaverVar) {
    MouseMove, 1, 0, 1, R  ;Move the mouse one pixel to the right
    MouseMove, -1, 0, 1, R ;Move the mouse back one pixel
}
return
