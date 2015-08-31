ArrayToString(arr, bef:="[", aft:="]", mid:=", ") {
	for each, value in arr
		res .= mid value
	return Format("{1}{2}{3}", bef, SubStr(res, StrLen(mid)+1), aft)
}
SendWord(CurrentWord,NewWord)
{
    Send, % "{BS " . StrLen(CurrentWord) . "}" ;clear the typed word
    SendRaw, %NewWord%
}
; :*:woops::
; ExitApp
; return
