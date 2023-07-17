print("load functions/modify/presentation.lua")
--local _ModifyLineFun = require 'vkdev.TodoList.functions.modify.line'
--local _NumDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'

local function Current_Day_Outline_to_Bold(dayNum)
	--local dayNameLine = _NumDayEqFun.Get_Day_String_line(dayNum)
	--local dayNameLine = _ReadDaysFun.GetDayStringLine(dayNum)
	local dayNameLine = _ReadDaysFun.GetDayStringLine(dayNum)
--	print("current day line = " .. dayNameLine)
	_ModifyLineFun.ReplaceStrAt('┌', '┏', dayNameLine - 1)
	_ModifyLineFun.ReplaceStrAt('┐', '┓', dayNameLine - 1)
	_ModifyLineFun.ReplaceStrAt('─', '━', dayNameLine - 1)
	_ModifyLineFun.ReplaceStrAt('│', '┃', dayNameLine)
	_ModifyLineFun.ReplaceStrAt('─', '━', dayNameLine + 1)
	_ModifyLineFun.ReplaceStrAt('┬', '┯', dayNameLine + 1)
	_ModifyLineFun.ReplaceStrAt('┘', '┛', dayNameLine + 1)
	_ModifyLineFun.ReplaceStrAt('└', '┗', dayNameLine + 1)
end


return {
	Current_Day_Outline_to_Bold = Current_Day_Outline_to_Bold,
}
