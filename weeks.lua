print("load weeks.lua")

_SystemVar = require 'vkdev.TodoList.variables.basic_variables'
_SyntaxVar = require 'vkdev.TodoList.variables.syntax_variables'
_ReadDaysFun = require 'vkdev.TodoList.functions.read.days'
_ModifyPresentationFun = require 'vkdev.TodoList.functions.modify.presentation'
_ReadFun = require 'vkdev.TodoList.functions.read.file'
_ModifyLineFun = require 'vkdev.TodoList.functions.modify.line'
_BufferFun = require 'vkdev.TodoList.functions.buffers'
_SyntaxFun = require 'vkdev.TodoList.functions.syntax'
_NumDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'
_NumMonthEqFun = require 'vkdev.TodoList.functions.number_month_eq'
_LineVar = require 'vkdev.TodoList.variables.line_variables'
_Wins = require 'vkdev.TodoList.functions.windows'
_Utils = require 'vkdev.TodoList.functions.utils'

vim.api.nvim_command('source ' .. _SystemVar.keymapLuaFilePath)
vim.api.nvim_command("source " .. _SystemVar.templateInsertLuaFilePath)
vim.api.nvim_command("source " .. _SystemVar.modifyListLuaFilePath)


--local ?

local function HideDay(dayNum)
	local dayTopStr = _NumDayEqFun.Get_Day_Top_String(dayNum)
	local dayStr = _NumDayEqFun.Get_Day_String(dayNum)
	local dayBotStr = _NumDayEqFun.Get_Day_Bot_String(dayNum)
	local dayStart = _ReadDaysFun.GetDayStringLine(dayNum)
	local dayEnd = _ReadDaysFun.GetDayListEndLine(dayNum)
	_SyntaxFun.Hightlight_Str_In_Gray(dayTopStr)
	_SyntaxFun.Hightlight_Str_In_Gray(dayStr)
	_SyntaxFun.Hightlight_Str_In_Gray(dayBotStr)
	_SyntaxFun.Fold_Between(dayStart, dayEnd)
	print(dayStr)
end


local function Move_Cursor_To_Current_Day_List(dayNum) 
	local line = _ReadDaysFun.GetDayListStartLine(dayNum)
	local column = 13
	vim.api.nvim_win_set_cursor(0, {line, column})
end

local function Handle_current_Day(dayNum)
	_SyntaxFun.Highlight_Current_Day_By_Num(dayNum)
	_ModifyPresentationFun.Current_Day_Outline_to_Bold(dayNum)
	Move_Cursor_To_Current_Day_List(dayNum)
end

local function Hil(currentDay)
	local dayNum = _NumDayEqFun.DayToNum(currentDay)
	Handle_current_Day(dayNum)

	if currentDay == "lundi" then
	elseif currentDay == "mardi" then
		HideDay(1)
	elseif currentDay == "mercredi" then
		HideDay(1)
		HideDay(2)
	elseif currentDay == "jeudi" then
		HideDay(1)
		HideDay(2)
		HideDay(3)
	elseif currentDay == "vendredi" then
		HideDay(1)
		HideDay(2)
		HideDay(3)
		HideDay(4)
	elseif currentDay == "samedi" then
		HideDay(1)
		HideDay(2)
		HideDay(3)
		HideDay(4)
		HideDay(5)
	elseif currentDay == "dimanche" then
		HideDay(1)
		HideDay(2)
		HideDay(3)
		HideDay(4)
		HideDay(5)
		HideDay(6)
	else
		print("Error in WeekDay")
	end
end

Hil(_SystemVar.weekDay)
