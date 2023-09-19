print("load weeks.lua")

_SystemVar = require 'vkdev.TodoList.variables.basic_variables'
_SyntaxVar = require 'vkdev.TodoList.variables.syntax_variables'
_NamesVar = require 'vkdev.TodoList.variables.daysName_variables'
_ReadDaysFun = require 'vkdev.TodoList.functions.read.days'
_ModifyPresentationFun = require 'vkdev.TodoList.functions.modify.presentation'
_ReadFun = require 'vkdev.TodoList.functions.read.file'
_ModifyLineFun = require 'vkdev.TodoList.functions.modify.line'
_BufferFun = require 'vkdev.TodoList.functions.window.buffers'
_SyntaxFun = require 'vkdev.TodoList.functions.syntax'
_NumDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'
_NumMonthEqFun = require 'vkdev.TodoList.functions.number_month_eq'
_LineVar = require 'vkdev.TodoList.variables.line_variables'
_Wins = require 'vkdev.TodoList.functions.window.windows'
_Utils = require 'vkdev.TodoList.functions.utils'

_VIM.api.nvim_command('source ' .. _SystemVar.keymapLuaFilePath)
_VIM.api.nvim_command("source " .. _SystemVar.templateInsertLuaFilePath)
_VIM.api.nvim_command("source " .. _SystemVar.modifyListLuaFilePath)

local function Move_Cursor_To_Current_Day_List(dayNum) 
	local line = _ReadDaysFun.GetDayListStartLine(dayNum)
	local column = 13
	_VIM.api.nvim_win_set_cursor(0, {line, column})
end

local function Handle_current_Day(dayNum)
	_SyntaxFun.Highlight_Current_Day_By_Num(dayNum)
	--day outline to bold should be checked whith a loop to the current day
	_ModifyPresentationFun.Current_Day_Outline_to_Bold(dayNum)
	Move_Cursor_To_Current_Day_List(dayNum)
end
local function Hil(currentDay)
	local dayNum = tonumber(_SystemVar.dayNrInTheWeek)
	print("Hil weekday : " .. dayNum)
	Handle_current_Day(dayNum)
	if dayNum == 1 then
		_ModifyPresentationFun.HideDaysTo(6)
	elseif dayNum > 1 then
		_ModifyPresentationFun.HideDaysTo(dayNum)
	end
end

Hil(_SystemVar.weekDay)
