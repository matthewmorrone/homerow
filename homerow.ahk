#NoEnv
#Warn LocalSameAsGlobal, Off
#SingleInstance force
AutoTrim, On

#Include generate-word-list.ahk
#Include suggest.ahk
#Include set-hotkeys.ahk
#Include util.ahk



Suggest:

mlist := Suggest(CurrentWord, Lookup)
If (m.MaxIndex() = 0)
{
    Gui, Hide
    Return
}
bar := ArrayToString(mlist, "", "", "|")
Gui, Suggestions:Default
Gui, Add, ListBox, x0 y0 vWord gSendWord AltSubmit, %bar%
Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound
Gui, Show

return


SendWord:

GuiControlGet, Index, , Word
Gui, Suggestions:Default
; Gui, Hide
Gui, Destroy
NewWord := mlist[Index]
SendWord(CurrentWord,NewWord)

;only trigger word completion on non-interface event or double click on matched list
; If (A_GuiEvent != "" && A_GuiEvent != "DoubleClick")
;     Return


a

a
return


;a
