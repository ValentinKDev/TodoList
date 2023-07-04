local systemVar = require 'vkdev.TodoList.variables.basic_variables'
local NumDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'
local SyntaxVar = require 'vkdev.TodoList.variables.syntax_variables'
local bufferFun = require 'vkdev.TodoList.functions.buffers'

local function ReplaceCharacterAt(target_char, replacement_char, line)
	--local line_content = vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1]
	--local updated_line_content = line_content:gsub(target_char, replacement_char)
	--vim.api.nvim_buf_set_lines(0, line, line + 1, false, {updated_line_content})
	local line_content = vim.api.nvim_buf_get_lines(1, line - 1, line, false)[1]
	local updated_line_content = line_content:gsub(target_char, replacement_char)
	vim.api.nvim_buf_set_lines(1, line - 1, line, false, {updated_line_content})
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
	local currentLine = vim.api.nvim_win_get_cursor(0)[1]
	local end_of_branch = Is_Line_Number_DayStr(currentLine + 2)
	if end_of_branch == true then
		ReplaceCharacterAt('└', '├', currentLine - 1)
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {SyntaxVar.end_branch_content})
	else 
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {SyntaxVar.new_branch_content})
	end
	vim.api.nvim_feedkeys("j", "n", false)
	vim.api.nvim_feedkeys("A", "n", false)
end

function BranchDone()
	local target_char = '─'
	--local replacement_char = '✕'
	local replacement_char = '✔'
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	--local currentLine = cursor_pos[1] - 1
	local currentLine = cursor_pos[1] 
--	if readingFun.IsWordInFileAtLine(replacement_char, systemVar.weekTodoPath, currentLine) then
	local buffer = bufferFun.GetBufferIdByName(systemVar.weekTodoPath)
	local lineContent = vim.api.nvim_buf_get_lines(buffer, currentLine - 1, currentLine, false)[1]
	if lineContent:find(replacement_char) then
		ReplaceCharacterAt(replacement_char, target_char, currentLine )
	else
		ReplaceCharacterAt(target_char, replacement_char, currentLine )
	end
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
