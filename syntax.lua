print("todo syntax")

local systemVar = require 'vkdev.plugins_config.TodoList.variables.basic_variables'
local syntaxVar = require 'vkdev.plugins_config.TodoList.variables.syntax_variables'
local lineVar = require 'vkdev.plugins_config.TodoList.variables.line_variables'
local readingFun = require 'vkdev.plugins_config.TodoList.functions.reading_file'
local modifyFun = require 'vkdev.plugins_config.TodoList.functions.modify'
local syntaxFun = require 'vkdev.plugins_config.TodoList.functions.syntax'
local numDayEqFun = require 'vkdev.plugins_config.TodoList.functions.number_day_eq'

vim.api.nvim_set_hl(0, "red", {fg='#aa0000' ,bg='#202020'})
vim.api.nvim_set_hl(0, "green", {fg='#00aa00'})
vim.api.nvim_set_hl(0, "yellow", {fg='#707000'})
vim.api.nvim_set_hl(0, "blue", {fg='#0070aa', bold=true})
vim.api.nvim_set_hl(0, "grayToHide", {fg='#656565'})
vim.api.nvim_set_hl(0, "yellow2", {fg='#bbaa00'})
vim.api.nvim_set_hl(0, "yellow3", {fg='#988500'})
vim.api.nvim_set_hl(0, "CursorLineNr", {bold=true, bg=Gray})

vim.fn.matchadd("yellow2", "SEMAINE") 
vim.fn.matchadd("yellow2", "#") 
vim.fn.matchadd("yellow3", "═") 
vim.fn.matchadd("yellow3", "║") 
vim.fn.matchadd("yellow3", "╠") 
vim.fn.matchadd("yellow3", "╔") 
vim.fn.matchadd("yellow3", "╚") 
vim.fn.matchadd("yellow3", "╗") 
vim.fn.matchadd("yellow3", "╝") 

vim.cmd[[ hi Folded guifg=#656565 guibg=#282828 ]]
vim.cmd[[ hi FoldColumn guibg=#050505 ]]
vim.cmd[[ hi DayBranch guifg=#555555]]  			
vim.cmd[[ match DayBranch /\s*\p✕.*\Z/ ]]  	

vim.keymap.set("n", "<Leader>tn", ":TodoNew<CR>")
vim.keymap.set("n", "<Leader>td", ":TodoDone<CR>")

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

local function Highlight_Current_Day_By_Num(dayNum)
	local dayTopStr = numDayEqFun.Get_Day_Top_String(dayNum)
	local dayStr = numDayEqFun.Get_Day_String(dayNum)
	local dayBotStr = numDayEqFun.Get_Day_Bot_String(dayNum)
	syntaxFun.Hightlight_Str_In_Blue(dayTopStr)
	syntaxFun.Hightlight_Str_In_Blue(dayStr)
	syntaxFun.Hightlight_Str_In_Blue(dayBotStr)
end

local function Move_Cursor_To_Current_Day_List(dayNum) 
	local line = numDayEqFun.Get_Day_List_Start_Line(dayNum)
	-- count column directly from a variable 
	local column = 8
--	vim.api.nvim_win_set_cursor(0, {line, column})
end

local function Handle_current_Day(dayNum)
	Highlight_Current_Day_By_Num(dayNum)
	modifyFun.Current_Day_Outline_to_Bold(dayNum)
end

local function Hil(currentDay)
	local dayNum = numDayEqFun.DayToNum(currentDay)
	Handle_current_Day(dayNum)
	Move_Cursor_To_Current_Day_List(dayNum)

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
