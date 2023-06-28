local syntaxVar = require 'vkdev.plugins_config.TodoList.variables.syntax_variables'
local lineVar = require 'vkdev.plugins_config.TodoList.variables.line_variables'

local function Get_Day_String_line(dayNum)
	local line = ""
	if (dayNum == 1) then line = lineVar.day1Line
	elseif dayNum == 2 then line = lineVar.day2Line
	elseif dayNum == 3 then line = lineVar.day3Line
	elseif dayNum == 4 then line = lineVar.day4Line
	elseif dayNum == 5 then line = lineVar.day5Line
	elseif dayNum == 6 then line = lineVar.day6Line
	elseif dayNum == 7 then line = lineVar.day7Line
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
	if (dayNum == 1) then str = syntaxVar.day1_Bot_Outline
	elseif dayNum == 2 then str = syntaxVar.day2_Bot_Outline
	elseif dayNum == 3 then str = syntaxVar.day3_Bot_Outline
	elseif dayNum == 4 then str = syntaxVar.day4_Bot_Outline
	elseif dayNum == 5 then str = syntaxVar.day5_Bot_Outline
	elseif dayNum == 6 then str = syntaxVar.day6_Bot_Outline
	elseif dayNum == 7 then str = syntaxVar.day7_Bot_Outline
	else print("Error in Get_Day_Top_String")
	end
	return str
end

local function Get_Day_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = syntaxVar.day1_Middle
	elseif dayNum == 2 then str = syntaxVar.day2_Middle
	elseif dayNum == 3 then str = syntaxVar.day3_Middle
	elseif dayNum == 4 then str = syntaxVar.day4_Middle
	elseif dayNum == 5 then str = syntaxVar.day5_Middle
	elseif dayNum == 6 then str = syntaxVar.day6_Middle
	elseif dayNum == 7 then str = syntaxVar.day7_Middle
	else print("Error in Get_Day_String")
	end
	return str
end


local function Get_Day_Top_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = syntaxVar.day1_Top_Outline
	elseif dayNum == 2 then str = syntaxVar.day2_Top_Outline
	elseif dayNum == 3 then str = syntaxVar.day3_Top_Outline
	elseif dayNum == 4 then str = syntaxVar.day4_Top_Outline
	elseif dayNum == 5 then str = syntaxVar.day5_Top_Outline
	elseif dayNum == 6 then str = syntaxVar.day6_Top_Outline
	elseif dayNum == 7 then str = syntaxVar.day7_Top_Outline
	else print("Error in Get_Day_Top_String")
	end
	return str
end

local function Get_Day_List_Start_Line(dayNum) 
	local line = -1 
	if (dayNum == 1) then line = lineVar.day1LineStart
	elseif dayNum == 2 then line = lineVar.day2LineStart
	elseif dayNum == 3 then line = lineVar.day3LineStart
	elseif dayNum == 4 then line = lineVar.day4LineStart
	elseif dayNum == 5 then line = lineVar.day5LineStart
	elseif dayNum == 6 then line = lineVar.day6LineStart
	elseif dayNum == 7 then line = lineVar.day7LineStart
	else print("Error in Get_Day_List_Start_Line")
	end
	return line
end

local function Get_Day_List_End_Line(dayNum) 
	local line = -1 
	if (dayNum == 1) then line = lineVar.day1LineEnd
	elseif dayNum == 2 then line = lineVar.day2LineEnd
	elseif dayNum == 3 then line = lineVar.day3LineEnd
	elseif dayNum == 4 then line = lineVar.day4LineEnd
	elseif dayNum == 5 then line = lineVar.day5LineEnd
	elseif dayNum == 6 then line = lineVar.day6LineEnd
	elseif dayNum == 7 then line = lineVar.day7LineEnd
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

