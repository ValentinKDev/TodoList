local systemVar = require 'vkdev.plugins_config.TodoList.variables.basic_variables'
local NumDayEqFun = require 'vkdev.plugins_config.TodoList.functions.number_day_eq'
local SyntaxVar = require 'vkdev.plugins_config.TodoList.variables.syntax_variables'

local function ReplaceCharacterAt(target_char, replacement_char, line)
	local line_content = vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1]
	local updated_line_content = line_content:gsub(target_char, replacement_char)
	vim.api.nvim_buf_set_lines(0, line, line + 1, false, {updated_line_content})
end

local function Current_Day_Outline_to_Bold(dayNum)
	local day_str_line = NumDayEqFun.Get_Day_String_line(dayNum)
	print("current day line = " .. day_str_line)
	ReplaceCharacterAt('─', '━', day_str_line - 2)
	ReplaceCharacterAt('┌', '┏', day_str_line - 2)
	ReplaceCharacterAt('┐', '┓', day_str_line - 2)
	ReplaceCharacterAt('│', '┃', day_str_line -1)
	ReplaceCharacterAt('─', '━', day_str_line)
	ReplaceCharacterAt('┬', '┯', day_str_line)
	ReplaceCharacterAt('┘', '┛', day_str_line)
	ReplaceCharacterAt('└', '┗', day_str_line)
end

function NewTodo()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local end_of_branch = Is_Line_Number_DayStr(current_line + 2)
	if end_of_branch == true then
		ReplaceCharacterAt('└', '├', current_line - 1)
		vim.api.nvim_buf_set_lines(0, current_line, current_line,false, {SyntaxVar.end_branch_content})
	else 
		vim.api.nvim_buf_set_lines(0, current_line, current_line,false, {SyntaxVar.new_branch_content})
	end
	vim.api.nvim_feedkeys("j", "n", false)
	vim.api.nvim_feedkeys("A", "n", false)
end

function BranchDone()
	local target_char = '─'
	local replacement_char = '✕'
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local current_line = cursor_pos[1] - 1
	ReplaceCharacterAt(target_char, replacement_char, current_line )
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end

local function TemplateInsert(sourceFile, startLineNumber)
	local file = io.open(sourceFile, "r")
	if not sourceFile then
		print("Failed to open source file: " .. sourceFile)
		return
	end
	local line_count = 1
	for line in file:lines() do
		line_count = line_count + 1
		local lineNumber = startLineNumber + line_count
		vim.api.nvim_buf_set_lines(0, lineNumber , lineNumber, false, {line})
	end
	file:close()
end

function DayWeekTemplateInsert()
	TemplateInsert(systemVar.dayTemplate, 10)
end

vim.cmd[[ command! -nargs=0 TodoNew :lua NewTodo() ]]
vim.cmd[[ command! -nargs=0 TodoDone :lua  BranchDone()]]
vim.cmd[[ command! -nargs=0 TodoDayTemplate :lua DayWeekTemplateInsert()]]

return {
	ReplaceCharacterAt = ReplaceCharacterAt,
	Current_Day_Outline_to_Bold = Current_Day_Outline_to_Bold,
	NewTodo = NewTodo,
	BranchDone = BranchDone,
}
