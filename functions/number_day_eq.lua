print("load functions/numer_day_eq.lua")

local function DayToNum(dayX)
	print("DayToNum : " .. dayX)
	local dayNum = -1
	if dayX == "Monday" then dayNum = 1
	elseif dayX == "Tuesday" then dayNum = 2
	elseif dayX == "Wednesday" then dayNum = 3
	elseif dayX == "Thursday" then dayNum = 4
	elseif dayX == "Friday" then dayNum = 5
	elseif dayX == "Saturday" then dayNum = 6
	elseif dayX == "Sunday" then dayNum = 7
--	if dayX == _NamesVar.day1 then dayNum = 1
--	elseif dayX == _NamesVar.day2 then dayNum = 2
--	elseif dayX == _NamesVar.day3 then dayNum = 3
--	elseif dayX == _NamesVar.day4 then dayNum = 4
--	elseif dayX == _NamesVar.day5 then dayNum = 5
--	elseif dayX == _NamesVar.day6 then dayNum = 6
--	elseif dayX == _NamesVar.day7 then dayNum = 7
	else dayNum = 0
	end
	print("Day : " .. dayNum)
	return dayNum
end

local function Get_Day_Bot_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = _SyntaxVar.day1_Bot_Outline
	elseif dayNum == 2 then str = _SyntaxVar.day2_Bot_Outline
	elseif dayNum == 3 then str = _SyntaxVar.day3_Bot_Outline
	elseif dayNum == 4 then str = _SyntaxVar.day4_Bot_Outline
	elseif dayNum == 5 then str = _SyntaxVar.day5_Bot_Outline
	elseif dayNum == 6 then str = _SyntaxVar.day6_Bot_Outline
	elseif dayNum == 7 then str = _SyntaxVar.day7_Bot_Outline
	else print("Error in Get_Day_Top_String, dayNum : " .. dayNum)
	end
	return str
end

local function Get_Day_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = _SyntaxVar.day1_Middle
	elseif dayNum == 2 then str = _SyntaxVar.day2_Middle
	elseif dayNum == 3 then str = _SyntaxVar.day3_Middle
	elseif dayNum == 4 then str = _SyntaxVar.day4_Middle
	elseif dayNum == 5 then str = _SyntaxVar.day5_Middle
	elseif dayNum == 6 then str = _SyntaxVar.day6_Middle
	elseif dayNum == 7 then str = _SyntaxVar.day7_Middle
	else print("Error in Get_Day_String, dayNum : " .. dayNum)
	end
	return str
end


local function Get_Day_Top_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = _SyntaxVar.day1_Top_Outline
	elseif dayNum == 2 then str = _SyntaxVar.day2_Top_Outline
	elseif dayNum == 3 then str = _SyntaxVar.day3_Top_Outline
	elseif dayNum == 4 then str = _SyntaxVar.day4_Top_Outline
	elseif dayNum == 5 then str = _SyntaxVar.day5_Top_Outline
	elseif dayNum == 6 then str = _SyntaxVar.day6_Top_Outline
	elseif dayNum == 7 then str = _SyntaxVar.day7_Top_Outline
	else print("Error in Get_Day_Top_String, dayNum : " .. dayNum)
	end
	return str
end

return {
	DayToNum = DayToNum,
	Get_Day_Bot_String = Get_Day_Bot_String,
	Get_Day_String = Get_Day_String,
	Get_Day_Top_String = Get_Day_Top_String,
}

