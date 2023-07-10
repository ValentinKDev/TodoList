print("todo syntax")

local systemVar = require 'vkdev.TodoList.variables.basic_variables'
local lineVar = require 'vkdev.TodoList.variables.line_variables'
local modifyFun = require 'vkdev.TodoList.functions.modify'
local syntaxFun = require 'vkdev.TodoList.functions.syntax'
local numDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'
local wins = require 'vkdev.TodoList.functions.windows'

vim.api.nvim_command('source ' .. systemVar.keymapLuaFilePath)
vim.api.nvim_command('source ' .. systemVar.templateInsertLuaFilePath)
--vim.api.nvim_command('source /home/vkdev/.config/nvim/lua/vkdev/TodoList/functions/modify/template_insertion.lua')


--local ?
function Is_Line_Number_DayStr(line)
	local ret = false
	if line == lineVar.day1Line then ret = true
	elseif line == lineVar.day2Line then ret = true
	elseif line == lineVar.day3Line then ret = true
	elseif line == lineVar.day4Line then ret = true
	elseif line == lineVar.day5Line then ret = true
	elseif line == lineVar.day6Line then ret = true
	elseif line == lineVar.day7Line then ret = true
	else ret = false
	end
	return ret
end

local function HideDay(dayNum)
	local dayTopStr = numDayEqFun.Get_Day_Top_String(dayNum)
	local dayStr = numDayEqFun.Get_Day_String(dayNum)
	local dayBotStr = numDayEqFun.Get_Day_Bot_String(dayNum)
	local dayStart = numDayEqFun.Get_Day_List_Start_Line(dayNum)
	local dayEnd = numDayEqFun.Get_Day_List_End_Line(dayNum)
	syntaxFun.Hightlight_Str_In_Gray(dayTopStr)
	syntaxFun.Hightlight_Str_In_Gray(dayStr)
	syntaxFun.Hightlight_Str_In_Gray(dayBotStr)
	syntaxFun.Fold_Between(dayStart, dayEnd)
	print(dayStr)
end


local function Move_Cursor_To_Current_Day_List(dayNum) 
	local line = numDayEqFun.Get_Day_List_Start_Line(dayNum)
	local column = 13
	vim.api.nvim_win_set_cursor(0, {line, column})
end

local function Handle_current_Day(dayNum)
	syntaxFun.Highlight_Current_Day_By_Num(dayNum)
	modifyFun.Current_Day_Outline_to_Bold(dayNum)
	Move_Cursor_To_Current_Day_List(dayNum)
end

local function Hil(currentDay)
	local dayNum = numDayEqFun.DayToNum(currentDay)
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

Hil(systemVar.weekDay)
