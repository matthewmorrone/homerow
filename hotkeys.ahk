

; NormalKeyList := "a`nd`nf`ng`nh`nj`nk`nl`nr`ns"
; NumberKeyList := "1`n2`n3`n4`n5`n6`n7`n8`n9`n0"
; OtherKeyList := "'`n-"
; ResetKeyList := "Esc`nSpace`nHome`nPGUP`nPGDN`nEnd`nLeft`nRight`nRButton`nMButton`n,`n.`n/`n[`n]`n;`n\`n=`n```n"""
; TriggerKeyList := "Tab`nEnter"

; SetHotkeys(NormalKeyList,NumberKeyList,OtherKeyList,ResetKeyList,TriggerKeyList)
; {
;     Loop, Parse, NormalKeyList, `n
;     {
;         Hotkey, ~%A_LoopField%, Key, UseErrorLevel
;         Hotkey, ~+%A_LoopField%, ShiftedKey, UseErrorLevel
;     }

;     Loop, Parse, NumberKeyList, `n
;     {
;         Hotkey, ~%A_LoopField%, Key, UseErrorLevel
;         Hotkey, ~Numpad%A_LoopField%, NumpadKey, UseErrorLevel
;     }

;     Loop, Parse, OtherKeyList, `n
;     {
;         Hotkey, ~%A_LoopField%, Key, UseErrorLevel
;     }

;     Loop, Parse, ResetKeyList, `n
;     {
;         Hotkey, ~*%A_LoopField%, ResetWord, UseErrorLevel
;     }

;     Hotkey, IfWinExist, AutoComplete ahk_class AutoHotkeyGUI
;     Loop, Parse, TriggerKeyList, `n
;     {
;         Hotkey, %A_LoopField%, MyListBox, UseErrorLevel
;     }
; }


; SetHotkeys(NormalKeyList,NumberKeyList,OtherKeyList,ResetKeyList,TriggerKeyList)


; ~BackSpace::
; CurrentWord := SubStr(CurrentWord,1,-1)
; If (CurrentWord = "") 
; {
;     Gosub, ResetWord
;     Return
; }
; Gosub, Suggest
; ; Gosub, ButtonOK
; Return

; Key:
; CurrentWord .= SubStr(A_ThisHotkey,2)
; Gosub, Suggest
; ; Gosub, ButtonOK
; Return

; ShiftedKey:
; Char := SubStr(A_ThisHotkey,3)
; StringUpper, Char, Char
; CurrentWord .= Char
; Gosub, Suggest
; ; Gosub, ButtonOK
; Return

; NumpadKey:
; CurrentWord .= SubStr(A_ThisHotkey,8)
; Gosub, Suggest
; ; Gosub, ButtonOK
; Return

; ResetWord:
; CurrentWord := ""
; Gui, Suggestions:Hide
; Return

