#SingleInstance force
#Include wordlist.ahk



CurrentWord := ""
ArrayToString(arr, bef:="[", aft:="]", mid:=", ") 
{
	res := ""
	for each, value in arr 
	{
		res .= mid value
	}
	return Format("{1}{2}{3}", bef, SubStr(res, StrLen(mid)+1), aft)
}
SendWord(CurrentWord,NewWord)
{	
	; MsgBox % CurrentWord " " NewWord
    Send, % "{BS " . StrLen(CurrentWord) . "}"
    SendRaw, %NewWord%
    Gosub, ResetWord
}
Suggest(CurrentWord, ByRef Lookup, Max:=10)
{
    MatchList := Array()
    i := MatchList.MaxIndex()
    Len := StrLen(CurrentWord)

    if (Len = 0) 
    {
    	return
    }

    for key, value in Lookup
    {
    	i := MatchList.MaxIndex()
    	if (i >= max) 
    	{
    		break
    	}
        StringLeft, sub, key, len
        if sub = %CurrentWord%
        {
        	Loop % value.MaxIndex() 
        	{
        		MatchList.Insert(value[A_Index])
        	}
        }
    }

    return, MatchList
}

Display:
Gui, Add, ListBox, h100 0x100 vMyListBox gMyListBox AltSubmit
Gui, +AlwaysOnTop +ToolWindow
Gui, Show, Autosize NA, Homerow
return

Suggest:
; GuiControlGet, CurrentWord,, Matched
MatchList := Suggest(CurrentWord, Lookup)
DisplayList := ArrayToString(MatchList, "|", "", "|")
GuiControl,, MyListBox, %DisplayList%
GuiControl, Choose, MyListBox, 1
return

MyListBox:
GuiControlGet, Index, , MyListBox
NewWord := MatchList[Index]
SendWord(CurrentWord, NewWord)
Gui, Hide
return


~a::
~s::
~d::
~f::
~g::
~h::
~j::
~k::
~l::

Gosub, ResetWord
Gui, Show, Autosize NA, %CurrentWord%
; Gosub, Display
return



#IfWinExist Homerow ahk_class AutoHotkeyGUI

q::
w::
e::
r::
t::
y::
u::
i::
o::
p::
z::
x::
c::
v::
b::
n::
m::
return

~a::
~s::
~d::
~f::
~g::
~h::
~j::
~k::
~l::
Gui, Show, Autosize NA
CurrentWord .= SubStr(A_ThisHotkey,2)
MsgBox 4, , %CurrentWord%, .5
Gosub, Suggest
return

~BackSpace::
CurrentWord := SubStr(CurrentWord,1,-1)
Gosub, Suggest
Return

Up::
GuiControlGet, Index, , MyListBox
GuiControl, Choose, MyListBox, % Index - 1
return

Down::
GuiControlGet, Index, , MyListBox
GuiControl, Choose, MyListBox, % Index + 1
return


1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
GuiControl, Choose, MyListBox, % A_ThisHotkey = 0 ? 10 : A_ThisHotkey
return

Space::
; Gosub, ResetWord
; return

Enter::
Tab::
Gosub, MyListBox
return


$~^s::
SplashTextOn,,,Reloading %A_ScriptName%,
Sleep,500
SplashTextOff
Reload
return
~^+s::exitapp

#IfWinExist



ResetWord:
; GuiControl,,Matched,
CurrentWord := ""
; Gui, Suggestions:Hide
return


^esc::
GuiEscape:
GuiClose:
ExitApp
