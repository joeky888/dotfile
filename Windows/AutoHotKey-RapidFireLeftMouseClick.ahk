; Ref https://www.autohotkey.com/boards/viewtopic.php?t=45036
f9::Suspend
LButton::
Loop
{
    SetMouseDelay 20
    Click
    If(GetKeyState("LButton","P")=0)
    Break
}
