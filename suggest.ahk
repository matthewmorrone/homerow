Suggest(CurrentWord, ByRef Lookup)
{
    MatchList := Array()
    i := MatchList.MaxIndex()
    Len := StrLen(CurrentWord)

    For key, value in Lookup
    {
    	i := MatchList.MaxIndex()
        if i > 9
            break
        StringLeft, sub, key, len
        if sub = %CurrentWord%
        {
	    	MatchList.Insert(value)
        }
    }

    Return, MatchList
}

