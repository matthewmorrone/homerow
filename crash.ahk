#SingleInstance force

ArrayToString(arr, bef:="[", aft:="]", mid:=", ") {
	for each, value in arr
		res .= mid value
	return Format("{1}{2}{3}", bef, SubStr(res, StrLen(mid)+1), aft)
}
ExploreObj(Obj, NewRow="`n", Equal="  =  ", Indent="`t", Depth=12, CurIndent="") { 
	for k,v in Obj 
		ToReturn .= CurIndent . k . (IsObject(v) && depth>1 ? NewRow . ExploreObj(v, NewRow, Equal, Indent, Depth-1, CurIndent . Indent) : Equal . v) . NewRow 
	return RTrim(ToReturn, NewRow) 
}
table = {}
out := ""
out .= "#Singleinstance Force`n"
out .= "#Include gui.ahk`n`n"
Loop
{
	FileReadLine, line, crash.tsv, %A_Index%
	if ErrorLevel
		break
	words := StrSplit(line, A_Tab)
	i := words.RemoveAt(1)
	o := words

	thing := {(i): o}
	table[(i)] := thing

	out .= ":*:" i "::`n"
	out .= "`tToGUI(""" ArrayToString(words, "", "", "|") """)`n"
	out .= "return`n"


	; MsgBox, 4, , % ExploreObj(thing)
	; MsgBox, 4, , % out
	; IfMsgBox, No
	; 	return
}
; MsgBox, 4, , % out
FileName := "replace.ahk"
file := FileOpen(FileName, "w")
file.Write(out)
file.Close()

Run, replace.ahk

; ^(\w+)\t(\w+)\t(\w+)\t(\w+)\t(\w+)\n
; $1\t$2 1\n$1\t$3 2\n$1\t$4 3\n$1\t$5 4\n
