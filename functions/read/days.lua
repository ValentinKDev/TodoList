local function GetDayStringLine(dayNum)
	local line = -1
	if (dayNum == 1) then line = _LineVar.day1Line
	elseif dayNum == 2 then line = _LineVar.day2Line
	elseif dayNum == 3 then line = _LineVar.day3Line
	elseif dayNum == 4 then line = _LineVar.day4Line
	elseif dayNum == 5 then line = _LineVar.day5Line
	elseif dayNum == 6 then line = _LineVar.day6Line
	elseif dayNum == 0 then line = _LineVar.day7Line
	else print("Error in Get_Day_String_Line")
	end
	return line
end

local function GetDayListStartLine(dayNum)
	local line = -1
	if (dayNum == 1) then line = _LineVar.day1LineStart
	elseif dayNum == 2 then line = _LineVar.day2LineStart
	elseif dayNum == 3 then line = _LineVar.day3LineStart
	elseif dayNum == 4 then line = _LineVar.day4LineStart
	elseif dayNum == 5 then line = _LineVar.day5LineStart
	elseif dayNum == 6 then line = _LineVar.day6LineStart
	elseif dayNum == 0 then line = _LineVar.day7LineStart
	else print("Error in Get_Day_List_Start_Line")
	end
	return line
end

local function GetDayListEndLine(dayNum)
	local line = -1
	if (dayNum == 1) then line = _LineVar.day1LineEnd
	elseif dayNum == 2 then line = _LineVar.day2LineEnd
	elseif dayNum == 3 then line = _LineVar.day3LineEnd
	elseif dayNum == 4 then line = _LineVar.day4LineEnd
	elseif dayNum == 5 then line = _LineVar.day5LineEnd
	elseif dayNum == 6 then line = _LineVar.day6LineEnd
	elseif dayNum == 0 then line = _LineVar.day7LineEnd
	else print("Error in Get_Day_List_End_Line")
	end
	return line
end

local function IsLineNumberDayStr(search)
	return _Utils.Contains({
		_LineVar.day1Line,
		_LineVar.day2Line,
		_LineVar.day3Line,
		_LineVar.day4Line,
		_LineVar.day5Line,
		_LineVar.day6Line,
		_LineVar.day7Line,
	}, search)
end

return {
	GetDayStringLine = GetDayStringLine,
	GetDayListStartLine = GetDayListStartLine,
	GetDayListEndLine = GetDayListEndLine,
	IsLineNumberDayStr = IsLineNumberDayStr,
}
