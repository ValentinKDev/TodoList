print("load functions/numer_day_eq.lua")
--local _SyntaxVar = require 'vkdev.TodoList.variables.syntax_variables'

local function DayToNum(dayX)
	local dayNum = -1
	if dayX == "lundi" then dayNum = 1
	elseif dayX == "mardi" then dayNum = 2
	elseif dayX == "mercredi" then dayNum = 3
	elseif dayX == "jeudi" then dayNum = 4
	elseif dayX == "vendredi" then dayNum = 5
	elseif dayX == "samedi" then dayNum = 6
	elseif dayX == "dimanche" then dayNum = 7
	else dayNum = 0
	end
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
	else print("Error in Get_Day_Top_String")
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
	else print("Error in Get_Day_String")
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
	else print("Error in Get_Day_Top_String")
	end
	return str
end

return {
 	--Get_Day_String_line = Get_Day_String_line,
	DayToNum = DayToNum,
	Get_Day_Bot_String = Get_Day_Bot_String,
	Get_Day_String = Get_Day_String,
	Get_Day_Top_String = Get_Day_Top_String,
--	Get_Day_List_Start_Line = Get_Day_List_Start_Line,
--	Get_Day_List_End_Line = Get_Day_List_End_Line,
}

