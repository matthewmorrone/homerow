; words := StrSplit(str, "|")
; For key, value in words
;	MsgBox %key% %value%
; Loop % words.MaxIndex()
; 	word = %words%[A_Index]
; 	MsgBox %word%
; 	LV_Add("", A_Index, word)
; LV_ModifyCol()
#NoEnv

#Warn All
#Warn LocalSameAsGlobal, Off

#MaxThreadsBuffer On
; Gui, Show
; return

; MyListBox:
; if A_GuiEvent = Normal
; {
;     LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
;     ; ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
;     ; WinActivate
;     ; Send %RowText%
;     ; Clipboard = %RowText%
;     ; Clipboard := RowText
;     ; Send {^v}
;     ; MsgBox %RowText%
;     ; Gui, Submit
; }
; return

; GuiClose:
; 	ExitApp
; return
CoordMode, Caret
OffsetX := 0 ;offset in caret position in X axis
OffsetY := 20 ;offset from caret position in Y axis
;obtain desktop size across all monitors
SysGet, ScreenWidth, 78
SysGet, ScreenHeight, 79
MaxWidth := 0
BoxHeight := 100 ;height of the suggestions box in pixels

ToGUI(str)
{
	global
	Gui, Destroy

	; local
	; gOutput
	; Gui, Font, s14 c885555
	Gui, Add, ListBox, x0 y0, %str%
	Gui, Add, Button, Default, OK
	; Gui, +Delimiter`n
	Gui, +ToolWindow -Caption +AlwaysOnTop +LastFound
	; Gui, -SysMenu
	; Gui, +LastFound
	; Gui, +E0x08000000
	; Gui, -Border
	; hWindow := WinExist()



	; PosX := A_CaretX + OffsetX
	; If PosX + MaxWidth > ScreenWidth ;past right side of the screen
	;     PosX := ScreenWidth - MaxWidth
	; PosY := A_CaretY + OffsetY
	; If PosY + BoxHeight > ScreenHeight ;past bottom of the screen
	;     PosY := ScreenHeight - BoxHeight
	Gui, Show, NA
 	; Gui, Show, AutoSize Center NoActivate





	; Output:
	ButtonOK:

	; If (A_GuiEvent != "" && A_GuiEvent != "DoubleClick")
	; 	return
		GuiControlGet, Output  ; Retrieve the ListBox's current selection.
		; MsgBox, 4,, %Output%
		; WinActivate Sublime
	    Send, % "{BS " . StrLen(Output) . "}" ;clear the typed word
	    SendRaw, %Output%
	    ; if output <> ""
	    ; {
	    ; 	Gui, Destroy
	    ; }
	return


	; ; return
	; GuiClose:
	; GuiEscape:
	; ; ExitApp
	; Gui, Destroy
	return
}

:*:woops::
ExitApp
return
