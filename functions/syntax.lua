local NumDayEqFun = require 'vkdev.plugins_config.TodoList.functions.number_day_eq'

local function Hightlight_Str_In_Gray(str) 
	vim.fn.matchadd("grayToHide", str) 
end

local function Hightlight_Str_In_Blue(str) 
	vim.fn.matchadd("blue", str) 
end

local function Fold_Between(startLine, endLine) 
	vim.cmd(string.format("%s,%sfo", startLine, endLine)) 
end

local function Highlight_Current_Day_By_Num(dayNum)
	local dayTopStr = NumDayEqFun.Get_Day_Top_String(dayNum)
	local dayStr = NumDayEqFun.Get_Day_String(dayNum)
	local dayBotStr = NumDayEqFun.Get_Day_Bot_String(dayNum)
	Hightlight_Str_In_Blue(dayStr)
	Hightlight_Str_In_Blue(dayTopStr)
	Hightlight_Str_In_Blue(dayBotStr)
end

return {
	Hightlight_Str_In_Blue = Hightlight_Str_In_Blue,
	Hightlight_Str_In_Gray = Hightlight_Str_In_Gray,
	Fold_Between = Fold_Between,
	Highlight_Current_Day_By_Num = Highlight_Current_Day_By_Num,
}
