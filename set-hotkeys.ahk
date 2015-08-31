NormalKeyList := "a`nb`nc`nd`ne`nf`ng`nh`ni`nj`nk`nl`nm`nn`no`np`nq`nr`ns`nt`nu`nv`nw`nx`ny`nz" ;list of key names separated by `n that make up words in upper and lower case variants
NumberKeyList := "1`n2`n3`n4`n5`n6`n7`n8`n9`n0" ;list of key names separated by `n that make up words as well as their numpad equivalents
OtherKeyList := "'`n-" ;list of key names separated by `n that make up words
ResetKeyList := "Esc`nSpace`nHome`nPGUP`nPGDN`nEnd`nLeft`nRight`nRButton`nMButton`n,`n.`n/`n[`n]`n;`n\`n=`n```n"""  ;list of key names separated by `n that cause suggestions to reset
TriggerKeyList := "Tab`nEnter" ;list of key names separated by `n that trigger completion

SetHotkeys(NormalKeyList,NumberKeyList,OtherKeyList,ResetKeyList,TriggerKeyList)
{
    Loop, Parse, NormalKeyList, `n
    {
        Hotkey, ~%A_LoopField%, Key, UseErrorLevel
        Hotkey, ~+%A_LoopField%, ShiftedKey, UseErrorLevel
    }

    Loop, Parse, NumberKeyList, `n
    {
        Hotkey, ~%A_LoopField%, Key, UseErrorLevel
        Hotkey, ~Numpad%A_LoopField%, NumpadKey, UseErrorLevel
    }

    Loop, Parse, OtherKeyList, `n
        Hotkey, ~%A_LoopField%, Key, UseErrorLevel

    Loop, Parse, ResetKeyList, `n
        Hotkey, ~*%A_LoopField%, ResetWord, UseErrorLevel

    ; Hotkey, IfWinExist, AutoComplete ahk_class AutoHotkeyGUI
    ; Loop, Parse, TriggerKeyList, `n
    ;     Hotkey, %A_LoopField%, CompleteWord, UseErrorLevel
}


SetHotkeys(NormalKeyList,NumberKeyList,OtherKeyList,ResetKeyList,TriggerKeyList)



~BackSpace::
CurrentWord := SubStr(CurrentWord,1,-1)
Gosub, Suggest
Return

Key:
CurrentWord .= SubStr(A_ThisHotkey,2)
Gosub, Suggest
Return

ShiftedKey:
Char := SubStr(A_ThisHotkey,3)
StringUpper, Char, Char
CurrentWord .= Char
Gosub, Suggest
Return

NumpadKey:
CurrentWord .= SubStr(A_ThisHotkey,8)
Gosub, Suggest
Return

ResetWord:
CurrentWord := ""
Gui, Suggestions:Hide
Return

; Suggest:
; Gui, Suggestions:Default






