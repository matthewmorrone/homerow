IniRead, MaxResults, %SettingsFile%, Settings, MaxResults, %MaxResults%
IniRead, ShowLength, %SettingsFile%, Settings, ShowLength, %ShowLength%
IniRead, CorrectCase, %SettingsFile%, Settings, CorrectCase, %CorrectCase%

IniRead, NormalKeyList, %SettingsFile%, Keys, NormalKeyList, %NormalKeyList%
NormalKeyList := URLDecode(NormalKeyList)
IniRead, NumberKeyList, %SettingsFile%, Keys, NumberKeyList, %NumberKeyList%
NumberKeyList := URLDecode(NumberKeyList)
IniRead, OtherKeyList, %SettingsFile%, Keys, OtherKeyList, %OtherKeyList%
OtherKeyList := URLDecode(OtherKeyList)
IniRead, ResetKeyList, %SettingsFile%, Keys, ResetKeyList, %ResetKeyList%
ResetKeyList := URLDecode(ResetKeyList)
IniRead, TriggerKeyList, %SettingsFile%, Keys, TriggerKeyList, %TriggerKeyList%
TriggerKeyList := URLDecode(TriggerKeyList)







ExitSub:
Gui, Settings:Submit

;write settings
IniWrite, % URLEncode(MaxResults), %SettingsFile%, Settings, MaxResults
IniWrite, % URLEncode(ShowLength), %SettingsFile%, Settings, ShowLength
IniWrite, % URLEncode(CorrectCase), %SettingsFile%, Settings, CorrectCase

IniWrite, % URLEncode(NormalKeyList), %SettingsFile%, Keys, NormalKeyList
IniWrite, % URLEncode(NumberKeyList), %SettingsFile%, Keys, NumberKeyList
IniWrite, % URLEncode(OtherKeyList), %SettingsFile%, Keys, OtherKeyList
IniWrite, % URLEncode(ResetKeyList), %SettingsFile%, Keys, ResetKeyList
IniWrite, % URLEncode(TriggerKeyList), %SettingsFile%, Keys, TriggerKeyList

;write wordlist file
File := FileOpen(WordListFile,"w")
File.Seek(0)
Length := File.Write(WordList)
File.Length := Length
ExitApp
