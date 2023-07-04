local SyntaxVar = require 'vkdev.TodoList.variables.syntax_variables'
local LineVar = require 'vkdev.TodoList.variables.line_variables'

local function Get_Day_String_line(dayNum)
	local line = ""
	if (dayNum == 1) then line = LineVar.day1Line
	elseif dayNum == 2 then line = LineVar.day2Line
	elseif dayNum == 3 then line = LineVar.day3Line
	elseif dayNum == 4 then line = LineVar.day4Line
	elseif dayNum == 5 then line = LineVar.day5Line
	elseif dayNum == 6 then line = LineVar.day6Line
	elseif dayNum == 7 then line = LineVar.day7Line
	else print("Error in Get_Day_String_Line")
	end
	return line
end

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
	if (dayNum == 1) then str = SyntaxVar.day1_Bot_Outline
	elseif dayNum == 2 then str = SyntaxVar.day2_Bot_Outline
	elseif dayNum == 3 then str = SyntaxVar.day3_Bot_Outline
	elseif dayNum == 4 then str = SyntaxVar.day4_Bot_Outline
	elseif dayNum == 5 then str = SyntaxVar.day5_Bot_Outline
	elseif dayNum == 6 then str = SyntaxVar.day6_Bot_Outline
	elseif dayNum == 7 then str = SyntaxVar.day7_Bot_Outline
	else print("Error in Get_Day_Top_String")
	end
	return str
end

local function Get_Day_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = SyntaxVar.day1_Middle
	elseif dayNum == 2 then str = SyntaxVar.day2_Middle
	elseif dayNum == 3 then str = SyntaxVar.day3_Middle
	elseif dayNum == 4 then str = SyntaxVar.day4_Middle
	elseif dayNum == 5 then str = SyntaxVar.day5_Middle
	elseif dayNum == 6 then str = SyntaxVar.day6_Middle
	elseif dayNum == 7 then str = SyntaxVar.day7_Middle
	else print("Error in Get_Day_String")
	end
	return str
end


local function Get_Day_Top_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = SyntaxVar.day1_Top_Outline
	elseif dayNum == 2 then str = SyntaxVar.day2_Top_Outline
	elseif dayNum == 3 then str = SyntaxVar.day3_Top_Outline
	elseif dayNum == 4 then str = SyntaxVar.day4_Top_Outline
	elseif dayNum == 5 then str = SyntaxVar.day5_Top_Outline
	elseif dayNum == 6 then str = SyntaxVar.day6_Top_Outline
	elseif dayNum == 7 then str = SyntaxVar.day7_Top_Outline
	else print("Error in Get_Day_Top_String")
	end
	return str
end

local function Get_Day_List_Start_Line(dayNum) 
	local line = -1 
	if (dayNum == 1) then line = LineVar.day1LineStart
	elseif dayNum == 2 then line = LineVar.day2LineStart
	elseif dayNum == 3 then line = LineVar.day3LineStart
	elseif dayNum == 4 then line = LineVar.day4LineStart
	elseif dayNum == 5 then line = LineVar.day5LineStart
	elseif dayNum == 6 then line = LineVar.day6LineStart
	elseif dayNum == 7 then line = LineVar.day7LineStart
	else print("Error in Get_Day_List_Start_Line")
	end
	return line
end

local function Get_Day_List_End_Line(dayNum) 
	local line = -1 
	if (dayNum == 1) then line = LineVar.day1LineEnd
	elseif dayNum == 2 then line = LineVar.day2LineEnd
	elseif dayNum == 3 then line = LineVar.day3LineEnd
	elseif dayNum == 4 then line = LineVar.day4LineEnd
	elseif dayNum == 5 then line = LineVar.day5LineEnd
	elseif dayNum == 6 then line = LineVar.day6LineEnd
	elseif dayNum == 7 then line = LineVar.day7LineEnd
	else print("Error in Get_Day_List_End_Line")
	end
	return line
end

return {
 	Get_Day_String_line = Get_Day_String_line,
	DayToNum = DayToNum,
	Get_Day_Bot_String = Get_Day_Bot_String,
	Get_Day_String = Get_Day_String,
	Get_Day_Top_String = Get_Day_Top_String,
	Get_Day_List_Start_Line = Get_Day_List_Start_Line,
	Get_Day_List_End_Line = Get_Day_List_End_Line,
}

