#NoEnv

#SingleInstance force

#Warn All
#Warn LocalSameAsGlobal, Off

#MaxThreadsBuffer On

SetBatchLines, -1

F1::Suspend

WordListFile := A_ScriptDir . "\one.tsv" ;path of the wordlist file
SettingsFile := A_ScriptDir . "\settings.ini" ;path of the settings file

MaxResults := 5 ;maximum number of results to display
OffsetX := 0 ;offset in caret position in X axis
OffsetY := 20 ;offset from caret position in Y axis
BoxHeight := 38 ;height of the suggestions box in pixels
ShowLength := 2 ;minimum length of word before showing suggestions
CorrectCase := True ;whether or not to fix uppercase or lowercase to match the suggestion


; NormalKeyList := "a`nb`nc`nd`ne`nf`ng`nh`ni`nj`nk`nl`nm`nn`no`np`nq`nr`ns`nt`nu`nv`nw`nx`ny`nz" ;list of key names separated by `n that make up words in upper and lower case variants
NormalKeyList := "a`ns`nd`nf`ng`nh`nj`nk`nl" ;list of key names separated by `n that make up words in upper and lower case variants
NumberKeyList := "1`n2`n3`n4`n5`n6`n7`n8`n9`n0" ;list of key names separated by `n that make up words as well as their numpad equivalents
OtherKeyList := "'`n-" ;list of key names separated by `n that make up words
ResetKeyList := "Home`nPGUP`nPGDN`nEnd`nLeft`nRight`nRButton`nMButton`n,`n.`n/`n[`n]`n;`n\`n=`n```n"""  ;list of key names separated by `n that cause suggestions to reset
ResetKeyList .= "`nq`nw`ne`nr`nt`ny`nu`ni`no`np`nz`nx`nc`nv`nb`nn`nm"
TriggerKeyList := "Tab`nEnter`nSpace" ;list of key names separated by `n that trigger completion

TrayTip, Settings, Click the tray icon to modify settings, 5, 1

; CoordMode, Caret
SetKeyDelay, 0
SendMode, Input

;obtain desktop size across all monitors
SysGet, ScreenWidth, 78
SysGet, ScreenHeight, 79

FileRead, WordList, %WordListFile%
PrepareWordList(WordList)

;set up tray menu
Menu, Tray, NoStandard
Menu, Tray, Click, 1
Menu, Tray, Add, Settings, ShowSettings
Menu, Tray, Add
Menu, Tray, Add, Exit, ExitScript
Menu, Tray, Default, Settings

;set up suggestions window
Gui, Suggestions:Default
Gui, Font, s10, Courier New
Gui, +Delimiter`n
Gui, Add, ListBox, x0 y0 hwndHLB 0x100 vMatched gCompleteWord AltSubmit
Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound
hWindow := WinExist()
Gui, Show, h%BoxHeight% Hide, AutoComplete

Gosub, ResetWord

SetHotkeys(NormalKeyList,NumberKeyList,OtherKeyList,ResetKeyList,TriggerKeyList)

OnExit, ExitSub
Return

ExitSub:
ExitScript:
ExitApp

ShowSettings:
;do not show settings window if already shown
Gui, Settings:+LastFoundExist
If WinExist()
    Return

Gui, Settings:Default
Gui, Font,, Arial
Gui, Font,, Century Gothic
Gui, Color, White, FFF8F8

Gui, Font, s24 cFFAAAA
Gui, Add, Text, x10 y10 w540 h45 Center, a u t o c o m p l e t e
Gui, Add, Progress, x10 y55 w540 h1 BackgroundEEDDDD, 0

Gui, Font, s14 c885555
Gui, Add, Text, x10 y73 w180 h30, RESULT LIMIT
Gui, Add, Edit, x190 y70 w80 h30 Right Number
Gui, Add, UpDown, Range1-100 vMaxResults, %MaxResults%
Gui, Add, Text, x10 y113 w180 h30, TRIGGER LENGTH
Gui, Add, Edit, x190 y110 w80 h30 Right Number
Gui, Add, UpDown, Range1-10, %ShowLength%

Gui, Add, Checkbox, x10 y150 w260 h30 Checked%CorrectCase% vCorrectCase, CASE CORRECTION

Gui, Add, Edit, x10 y210 w115 h30 vNewKey
Gui, Add, Edit, x125 y210 w115 h30 vNewWord
Gui, Add, Button, x240 y210 w30 h30 Disabled vAddWord gAddWord, +
Gui, Add, Button, x10 y250 w260 h40 Disabled vRemoveWord gRemoveWord, REMOVE SELECTED
Gui, Font, s8, Courier New
Gui, Add, ListView, x290 y70 w260 h220 -Hdr vWords, Keys|Words

Gui, Color, White
Gui, +ToolWindow +AlwaysOnTop
Gui, Show, w560 h300, Autocomplete by Uberi & Matt

LV_Add("", "Reading wordlist...")
Sleep, 0

;populate list with entries from wordlist
GuiControl, -Redraw, Words
Loop, Parse, WordList, `n 
{
    pair := StrSplit(A_LoopField, A_Tab)
    LV_Add("", pair[1], pair[2])
}
LV_Delete(1)
GuiControl, +Redraw, Words
LV_ModifyCol()
GuiControl, Enable, AddWord
GuiControl, Enable, RemoveWord
Return

SettingsGuiEscape:
SettingsGuiClose:
Gui, Settings:Default
Gui, Submit
Gui, Destroy
Return

AddWord:
Gui, Settings:Default
GuiControlGet, NewKey,, NewKey
GuiControlGet, NewWord,, NewWord
Index := LV_Add("Select Focus", NewKey, NewWord)
LV_Modify(Index, "Vis")
WordList .= "`n" . NewKey . "`t" . NewWord
Return

RemoveWord:
Gui, Settings:Default
TempList := "`n" . WordList . "`n"
GuiControl, -Redraw, Words
While, CurrentRow := LV_GetNext()
{
    LV_Delete(CurrentRow)
    Position := InStr(TempList,"`n",True,1,CurrentRow)
    TempList := SubStr(TempList,1,Position) . SubStr(TempList,InStr(TempList,"`n",True,Position + 1) + 1)
}
GuiControl, +Redraw, Words
WordList := SubStr(TempList,2,-1)
Return

#IfWinExist AutoComplete ahk_class AutoHotkeyGUI

~LButton::
MouseGetPos,,, Temp1
If (Temp1 != hWindow)
    Gosub, ResetWord
Return

Up::
Gui, Suggestions:Default
GuiControlGet, Temp1,, Matched
If Temp1 > 1 ;ensure value is in range
    GuiControl, Choose, Matched, % Temp1 - 1
Return

Down::
Gui, Suggestions:Default
GuiControlGet, Temp1,, Matched
GuiControl, Choose, Matched, % Temp1 + 1
Return

1::
2::
3::
4::
5::
Gui, Suggestions:Default
KeyWait, Alt
; Key := SubStr(A_ThisHotkey, 2, 1)
Key := A_ThisHotKey
GuiControl, Choose, Matched, % Key = 0 ? 10 : Key
; Gosub, CompleteWord
Return

; Hotkey, Esc, ResetWord, UseErrorLevel
Esc::
Gosub, ResetWord
return

#IfWinExist

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

Suggest:
Gui, Suggestions:Default

;check word length against minimum length
If StrLen(CurrentWord) < 2
{
    Gui, Hide
    Return
}

MatchList := Suggest(CurrentWord,WordList)

;check for a lack of matches
If (MatchList = "")
{
    Gui, Hide
    Return
}

;limit the number of results
Position := InStr(MatchList,"`n",True,1,MaxResults)
If Position
{
    MatchList := SubStr(MatchList,1,Position - 1)
}

;find the longest text width and add numbers
MaxWidth := 0
DisplayList := ""
ItemCount := 0
Loop, Parse, MatchList, `n
{
    Entry := (A_Index < 10 ? A_Index . ". " : "   ") . A_LoopField
    Width := TextWidth(Entry)
    If (Width > MaxWidth)
    {
        MaxWidth := Width
    }
    DisplayList .= Entry . "`n"
    ItemCount++
}
MaxWidth += 30 ;add room for the scrollbar
DisplayList := SubStr(DisplayList,1,-1)

ItemHeight := 17
ListHeight := ItemCount * ItemHeight

GuiControl,, Matched, `n%DisplayList%
GuiControl, Choose, Matched, 1
GuiControl, Move, Matched, w%MaxWidth% h%ListHeight% ;set the control width
; PosX := A_CaretX + OffsetX
; If PosX + MaxWidth > ScreenWidth ;past right side of the screen
;     PosX := ScreenWidth - MaxWidth
; PosY := A_CaretY + OffsetY
; If PosY + BoxHeight > ScreenHeight ;past bottom of the screen
;     PosY := ScreenHeight - BoxHeight
MouseGetPos, PosX, PosY
Gui, Show, x%PosX% y%PosY% w%MaxWidth% h%ListHeight% NoActivate ;show window
LV_ModifyCol()
Return


CompleteWord:
Critical

;only trigger word completion on non-interface event or double click on matched list
If (A_GuiEvent != "" && A_GuiEvent != "DoubleClick")
    Return

Gui, Suggestions:Default
Gui, Hide

GuiControlGet, Index,, Matched
TempList := "`n" . MatchList . "`n"
Position := InStr(TempList,"`n",0,1,Index) + 1
NewWord := SubStr(TempList,Position,InStr(TempList,"`n",0,Position) - Position)
SendWord(CurrentWord,NewWord,CorrectCase)

Gosub, ResetWord
Return

PrepareWordList(ByRef WordList)
{
    If InStr(WordList,"`r")
    {
        StringReplace, WordList, WordList, `r,, All
    }
    While, InStr(WordList,"`n`n") ;remove blank lines within the list
    {
        StringReplace, WordList, WordList, `n`n, `n, All
    }
    WordList := Trim(WordList,"`n") ;remove blank lines at the beginning and end
}

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
    {
        Hotkey, ~%A_LoopField%, Key, UseErrorLevel
    }

    Loop, Parse, ResetKeyList, `n
    {
        Hotkey, ~*%A_LoopField%, ResetWord, UseErrorLevel
    }

    Hotkey, IfWinExist, AutoComplete ahk_class AutoHotkeyGUI
    Loop, Parse, TriggerKeyList, `n
    {
        Hotkey, %A_LoopField%, CompleteWord, UseErrorLevel
    }

    Hotkey, ~Space, CompleteWord, UseErrorLevel
}

Suggest(CurrentWord,ByRef WordList)
{
    Pattern := RegExReplace(CurrentWord,"S).","$0.*") ;subsequence matching pattern

    ;treat accented characters as equivalent to their unaccented counterparts
    Pattern := RegExReplace(Pattern,"S)[a" . Chr(224) . Chr(226) . "]","[a" . Chr(224) . Chr(226) . "]")
    Pattern := RegExReplace(Pattern,"S)[c" . Chr(231) . "]","[c" . Chr(231) . "]")
    Pattern := RegExReplace(Pattern,"S)[e" . Chr(233) . Chr(232) . Chr(234) . Chr(235) . "]","[e" . Chr(233) . Chr(232) . Chr(234) . Chr(235) . "]")
    Pattern := RegExReplace(Pattern,"S)[i" . Chr(238) . Chr(239) . "]","[i" . Chr(238) . Chr(239) . "]")
    Pattern := RegExReplace(Pattern,"S)[o" . Chr(244) . "]","[o" . Chr(244) . "]")
    Pattern := RegExReplace(Pattern,"S)[u" . Chr(251) . Chr(249) . "]","[u" . Chr(251) . Chr(249) . "]")

    Pattern := "`nimS)^" . Pattern ;match options

    ;search for words matching the pattern
    MatchList := ""
    Position := 1
    While, Position := RegExMatch(WordList,Pattern,Word,Position)
    {
        Position += StrLen(Word)
        ; StringReplace, Word, Word, %A_Tab%, %A_Space%%A_Space%%A_Space%%A_Space%, All ;convert tabs to spaces
        MatchList .= Word . "`n"
    }
    MatchList := SubStr(MatchList,1,-1) ;remove trailing delimiter

    ;sort by score
    SortedMatches := ""
    Loop, Parse, MatchList, `n
    {
        Pair := StrSplit(A_LoopField, A_Tab)
        Key := Pair[1]
        Val := Pair[2]
        if (StrLen(CurrentWord) = StrLen(Key)) 
        {
            SortedMatches .= Score(CurrentWord, Key) . "`t" . Val . "`n"
        }
    }
    
    SortedMatches := SubStr(SortedMatches,1,-1)
    ; Sort, SortedMatches, N R ;rank results numerically descending by score
    ; SortedMatches .= 100 . "`t" . CurrentWord . "`n"
    MatchList := RegExReplace(SortedMatches,"`nmS)^[^`t]+`t") ;remove scores

    Return, MatchList
}

Score(Word,Entry)
{
    Score := 100

    Length := StrLen(Word)

    ;determine prefixing
    Position := 1
    While, Position <= Length && SubStr(Word,Position,1) = SubStr(Entry,Position,1)
    {
        Position++
    }
    Score *= Position ** 8

    ;determine number of superfluous characters
    RegExMatch(Entry,"`nimS)^" . SubStr(RegExReplace(Word,"S).","$0.*"),1,-2),Remaining)
    Score *= (1 + StrLen(Remaining) - Length) ** -1.5

    Score *= StrLen(Word) ** 0.4

    Return, Score
}

SendWord(CurrentWord,NewWord,CorrectCase = True)
{
    If CorrectCase
    {
        Position := 1
        CaseSense := A_StringCaseSense
        StringCaseSense, Locale
        Loop, Parse, CurrentWord
        {
            Position := InStr(NewWord,A_LoopField,False,Position) ;find next character in the current word if only subsequence matched
            If A_LoopField Is Upper
            {
                Char := SubStr(NewWord,Position,1)
                StringUpper, Char, Char
                NewWord := SubStr(NewWord,1,Position - 1) . Char . SubStr(NewWord,Position + 1)
            }
        }
        StringCaseSense, %CaseSense%
    }

    ;send the word
    if (A_ThisHotKey = "Tab")
    {
        SendRaw, %A_Space%
    }
    if (A_ThisHotKey = "Enter")
    {
        SendRaw, %A_Space%
    }
    Send, % "{BS " . StrLen(CurrentWord)+1 . "}" ;clear the typed word
    SendRaw, %NewWord%
    ; if (A_ThisHotKey = "Space")
    ; {
        SendRaw, %A_Space%
    ; }
}

TextWidth(String)
{
    static Typeface := "Courier New"
    static Size := 10
    static hDC, hFont := 0, Extent
    If !hFont
    {
        hDC := DllCall("GetDC","UPtr",0,"UPtr")
        Height := -DllCall("MulDiv","Int",Size,"Int",DllCall("GetDeviceCaps","UPtr",hDC,"Int",90),"Int",72)
        hFont := DllCall("CreateFont","Int",Height,"Int",0,"Int",0,"Int",0,"Int",400,"UInt",False,"UInt",False,"UInt",False,"UInt",0,"UInt",0,"UInt",0,"UInt",0,"UInt",0,"Str",Typeface)
        hOriginalFont := DllCall("SelectObject","UPtr",hDC,"UPtr",hFont,"UPtr")
        VarSetCapacity(Extent,8)
    }
    DllCall("GetTextExtentPoint32","UPtr",hDC,"Str",String,"Int",StrLen(String),"UPtr",&Extent)
    Return, NumGet(Extent,0,"UInt")
}

URLEncode(Text)
{
    StringReplace, Text, Text, `%, `%25, All
    FormatInteger := A_FormatInteger, FoundPos := 0
    SetFormat, IntegerFast, Hex
    While, FoundPos := RegExMatch(Text,"S)[^\w-\.~%]",Char,FoundPos + 1)
        StringReplace, Text, Text, %Char%, % "%" . SubStr("0" . SubStr(Asc(Char),3),-1), All
    SetFormat, IntegerFast, %FormatInteger%
    Return, Text
}

URLDecode(Encoded)
{
    FoundPos := 0
    While, FoundPos := InStr(Encoded,"%",False,FoundPos + 1)
    {
        Value := SubStr(Encoded,FoundPos + 1,2)
        If (Value != "25")
            StringReplace, Encoded, Encoded, `%%Value%, % Chr("0x" . Value), All
    }
    StringReplace, Encoded, Encoded, `%25, `%, All
    Return, Encoded
}

GetClientHeight(HWND) 
{ 
    ; Retrieves the height of the client area.
    VarSetCapacity(RECT, 16, 0)
    DllCall("User32.dll\GetClientRect", "Ptr", HWND, "Ptr", &RECT)
    Return NumGet(RECT, 12, "Int")
}

LB_GetItemHeight(HLB) 
{ 
    ; Retrieves the height of a single list box item.
    ; LB_GETITEMHEIGHT = 0x01A1
    SendMessage, 0x01A1, 0, 0, , ahk_id %HLB%
    Return ErrorLevel
}

LB_GetCount(HLB) 
{ 
    ; Retrieves the number of items in the list box.
    ; LB_GETCOUNT = 0x018B
    SendMessage, 0x018B, 0, 0, , ahk_id %HLB%
    Return ErrorLevel
} 
