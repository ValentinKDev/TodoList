print("load functions/modify/presentation.lua")
--local _ModifyLineFun = require 'vkdev.TodoList.functions.modify.line'
--local _NumDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'

local function ReplaceOutlineByDayNum(dayNum)
	local dayNameLine = _ReadDaysFun.GetDayStringLine(dayNum)
	_ModifyLineFun.ReplaceStrAt('┌', '┏', dayNameLine - 1)
	_ModifyLineFun.ReplaceStrAt('┐', '┓', dayNameLine - 1)
	_ModifyLineFun.ReplaceStrAt('─', '━', dayNameLine - 1)
	_ModifyLineFun.ReplaceStrAt('│', '┃', dayNameLine)
	_ModifyLineFun.ReplaceStrAt('─', '━', dayNameLine + 1)
	_ModifyLineFun.ReplaceStrAt('┬', '┯', dayNameLine + 1)
	_ModifyLineFun.ReplaceStrAt('┘', '┛', dayNameLine + 1)
	_ModifyLineFun.ReplaceStrAt('└', '┗', dayNameLine + 1)
end

local function ReplaceOutlineToDayLine(dayNum)
	for i = 1, dayNum, 1 do ReplaceOutlineByDayNum(i) end
end

local function HideDay(dayNum)
	local dayTopStr = _NumDayEqFun.Get_Day_Top_String(dayNum)
	local dayStr = _NumDayEqFun.Get_Day_String(dayNum)
	local dayBotStr = _NumDayEqFun.Get_Day_Bot_String(dayNum)
	--local dayStart = _ReadDaysFun.GetDayStringLine(dayNum)
	local dayStart = _ReadDaysFun.GetDayListStartLine(dayNum)
	local dayEnd = _ReadDaysFun.GetDayListEndLine(dayNum)
	_SyntaxFun.Hightlight_Str_In_Gray(dayTopStr)
	_SyntaxFun.Hightlight_Str_In_Gray(dayStr)
	_SyntaxFun.Hightlight_Str_In_Gray(dayBotStr)
	_SyntaxFun.Fold_Between(dayStart, dayEnd)
	print(dayStr)
end

local function HideDaysTo(toDayNum) 
	local i = 1
	while i < toDayNum do 
		HideDay(i)
		i = i + 1
	end
end


return {
	HideDay = HideDay,
	HideDaysTo = HideDaysTo,
	ReplaceOutlineToDayLine = ReplaceOutlineToDayLine,
}
