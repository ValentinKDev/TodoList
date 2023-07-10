local systemVar = require 'vkdev.TodoList.variables.basic_variables'
local numDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'
local syntaxVar = require 'vkdev.TodoList.variables.syntax_variables'
local bufferFun = require 'vkdev.TodoList.functions.buffers'
local modifyLineFun = require 'vkdev.TodoList.functions.modify.line'


local function Current_Day_Outline_to_Bold(dayNum)
	local day_str_line = numDayEqFun.Get_Day_String_line(dayNum)
	print("current day line = " .. day_str_line)
	modifyLineFun.ReplaceStrAt('─', '━', day_str_line - 2)
	modifyLineFun.ReplaceStrAt('┌', '┏', day_str_line - 2)
	modifyLineFun.ReplaceStrAt('┐', '┓', day_str_line - 2)
	modifyLineFun.ReplaceStrAt('│', '┃', day_str_line -1)
	modifyLineFun.ReplaceStrAt('─', '━', day_str_line)
	modifyLineFun.ReplaceStrAt('┬', '┯', day_str_line)
	modifyLineFun.ReplaceStrAt('┘', '┛', day_str_line)
	modifyLineFun.ReplaceStrAt('└', '┗', day_str_line)
end

function NewTodo()
	local currentLine = vim.api.nvim_win_get_cursor(0)[1]
	local end_of_branch = Is_Line_Number_DayStr(currentLine + 2)
	if end_of_branch == true then
		modifyLineFun.ReplaceStrAt('└', '├', currentLine - 1)
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {syntaxVar.end_branch_content})
	else 
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {syntaxVar.new_branch_content})
	end
	vim.api.nvim_feedkeys("j", "n", false)
	vim.api.nvim_feedkeys("A", "n", false)
end

function BranchDone()
	local target_char = '─'
	local replacement_char = '✔'
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local currentLine = cursor_pos[1]
	local buffer = bufferFun.GetBufferIdByName(systemVar.weekTodoPath)
	local lineContent = vim.api.nvim_buf_get_lines(buffer, currentLine - 1, currentLine, false)[1]
	if lineContent:find(replacement_char) then
		modifyLineFun.ReplaceStrAt(replacement_char, target_char, currentLine )
	else
		modifyLineFun.ReplaceStrAt(target_char, replacement_char, currentLine )
	end
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end

vim.cmd[[ command! -nargs=0 TodoNew :lua NewTodo() ]]
vim.cmd[[ command! -nargs=0 TodoDone :lua  BranchDone()]]

return {
	Current_Day_Outline_to_Bold = Current_Day_Outline_to_Bold,
	NewTodo = NewTodo,
	BranchDone = BranchDone,
}
