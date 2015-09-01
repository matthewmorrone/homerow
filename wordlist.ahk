
WordListFile1 := A_ScriptDir . "\one-to-one.tsv"
FileRead, WordList1, %WordListFile1%
PrepareWordList(WordList1)

WordListFile2 := A_ScriptDir . "\one-to-many.tsv"
FileRead, WordList2, %WordListFile2%
PrepareWordList(WordList2)

WordList := WordList2 "`n" WordList1
Words := StrSplit(WordList, "`n")
Lookup := Object()
For index, value in Words
{
	line := StrSplit(value, A_Tab)
    key := line.Remove(1)
    ; val := ArrayToString(line, "", "", "|")
    Lookup[key] := line

}

PrepareWordList(ByRef WordList)
{
    If InStr(WordList,"`r") 
    {
        StringReplace, WordList, WordList, `r,, All
    }
    While, InStr(WordList,"`n`n") 
    {
        StringReplace, WordList, WordList, `n`n, `n, All
    }
    WordList := Trim(WordList,"`n") ;remove blank lines at the beginning and end
}
; For index, value in Lookup
; {
;     MsgBox, 4,, % index " " value[1]
;     IfMsgBox, No
;         break
; }
