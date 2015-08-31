#NoEnv
#Warn LocalSameAsGlobal, Off
AutoTrim, On

WordListFile1 := A_ScriptDir . "\one-to-one.tsv"
FileRead, WordList1, %WordListFile1%
PrepareWordList(WordList1)

WordListFile2 := A_ScriptDir . "\many-to-many.tsv"
FileRead, WordList2, %WordListFile2%
PrepareWordList(WordList2)

WordList := WordList2 "`n" WordList1
Words := StrSplit(WordList, "`n")
Lookup := Object()
For index, value in Words
{
	Pair := StrSplit(value, A_Tab)
	Lookup[Pair[1]] := Pair[2]
}

; FileName := "many-to-one.tsv"
; file := FileOpen(FileName, "w")
; For index, value in Lookup
; 	file.Write(index A_Tab value "`n")
; file.Close()

; ExitApp


PrepareWordList(ByRef WordList)
{
    If InStr(WordList,"`r")
        StringReplace, WordList, WordList, `r,, All
    While, InStr(WordList,"`n`n") ;remove blank lines within the list
        StringReplace, WordList, WordList, `n`n, `n, All
    WordList := Trim(WordList,"`n") ;remove blank lines at the beginning and end
}
