local systemVar = require 'vkdev.TodoList.variables.basic_variables'
local numDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'
local numMonthEqFun = require 'vkdev.TodoList.functions.number_month_eq'
local SyntaxVar = require 'vkdev.TodoList.variables.syntax_variables'
local bufferFun = require 'vkdev.TodoList.functions.buffers'

local function ReplaceStrAt(target_char, replacement_char, line)
	--local line_content = vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1]
	--local updated_line_content = line_content:gsub(target_char, replacement_char)
	--vim.api.nvim_buf_set_lines(0, line, line + 1, false, {updated_line_content})
	local line_content = vim.api.nvim_buf_get_lines(1, line - 1, line, false)[1]
	local updated_line_content = line_content:gsub(target_char, replacement_char)
	vim.api.nvim_buf_set_lines(1, line - 1, line, false, {updated_line_content})
end

local function Current_Day_Outline_to_Bold(dayNum)
	local day_str_line = numDayEqFun.Get_Day_String_line(dayNum)
	print("current day line = " .. day_str_line)
	ReplaceStrAt('─', '━', day_str_line - 2)
	ReplaceStrAt('┌', '┏', day_str_line - 2)
	ReplaceStrAt('┐', '┓', day_str_line - 2)
	ReplaceStrAt('│', '┃', day_str_line -1)
	ReplaceStrAt('─', '━', day_str_line)
	ReplaceStrAt('┬', '┯', day_str_line)
	ReplaceStrAt('┘', '┛', day_str_line)
	ReplaceStrAt('└', '┗', day_str_line)
end

function NewTodo()
	local currentLine = vim.api.nvim_win_get_cursor(0)[1]
	local end_of_branch = Is_Line_Number_DayStr(currentLine + 2)
	if end_of_branch == true then
		ReplaceStrAt('└', '├', currentLine - 1)
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {SyntaxVar.end_branch_content})
	else 
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {SyntaxVar.new_branch_content})
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
		ReplaceStrAt(replacement_char, target_char, currentLine )
	else
		ReplaceStrAt(target_char, replacement_char, currentLine )
	end
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- [[
-- Function to insert a new week day by day template and fill or replace "XX" "MMMM" "|" ";" "," 
-- elements by an accurate date and an elegante presentation
-- ]]
local function WeekTemplateInsert()
	local file = io.open(systemVar.weekTemplate, "r")
	if not systemVar.weekTemplate then
		print("Failed to open source file: " .. systemVar.weekTemplate)
		return
	end
	local startLineNumber = 10
	local line_count = 1
	for line in file:lines() do
		line_count = line_count + 1
		local lineNumber = startLineNumber + line_count
		vim.api.nvim_buf_set_lines(0, lineNumber , lineNumber, false, {line})
	end
	file:close()

	local startNr = systemVar.dayNrInTheMonth - (systemVar.dayNrInTheWeek - 1)
	local startStr = ""
	local minusMonth = false
	if startNr < 10 then
		startStr = "0" .. startNr
	elseif startNr < 1 then
		minusMonth = true
		startNr = numMonthEqFun.GetMonthMaxDays(systemVar.monthNr - 1)
		startStr = startNr
	else
		startStr = startStr
	end
	ReplaceStrAt("XX", startStr, 15)

	local startMonth = minusMonth and numMonthEqFun.GetMonthName(systemVar.monthNr) or systemVar.monthName
	print("monthNr : " .. systemVar.monthNr)
	print("startmonth : " .. startMonth)
--	print("startmonth len : " .. startMonth:len())
	ReplaceStrAt("MMMMM", startMonth, 15)

	local nrStartSyntax = "━"
	local i = 0
	local startMonthLen = tonumber(startMonth:len())
	while i < startMonthLen do
		nrStartSyntax = nrStartSyntax .. "━"
		i = i + 1
	end
	ReplaceStrAt(";", nrStartSyntax, 14)
	ReplaceStrAt(";", nrStartSyntax, 16)


	local plusMonth = false
	local endNr = startNr + 6
	local endStr = ""
	if endNr < 10 then
		endStr = "0" .. endNr
	elseif endNr > numMonthEqFun.GetMonthMaxDays(systemVar.monthNr) then
		plusMonth = true
		endNr = endNr - numMonthEqFun.GetMonthMaxDays(systemVar.monthNr)
		endStr = endNr
	else
		endStr = endNr
	end
	ReplaceStrAt("YY", endStr, 15)
	local endMonth = plusMonth and numMonthEqFun.GetMonthName(tonumber(systemVar.monthNr) + 1) or systemVar.monthName
	ReplaceStrAt("mmmmm", endMonth, 15)

	local nrEndSyntax = "━"
	i = 0
	local endMonthLen = tonumber(endMonth:len())
	while i < endMonthLen do
		nrEndSyntax = nrEndSyntax .. "━"
		i = i + 1
	end
	ReplaceStrAt(",", nrStartSyntax, 14)
	ReplaceStrAt(",", nrStartSyntax, 16)

	local nrMidSyntax = ""
	local nrBotEndSyntax = ""
	local nrTopEndSyntax = ""
	local len = 28
	len = len - startMonthLen - endMonthLen
	i = 0
	while i < len do
		nrMidSyntax = nrMidSyntax .. "═"
		nrBotEndSyntax = nrBotEndSyntax .. " "
		nrTopEndSyntax = nrTopEndSyntax .. ":"
		i = i + 1
	end
	ReplaceStrAt("|", nrBotEndSyntax, 14)
	ReplaceStrAt("|", nrMidSyntax, 15)
	ReplaceStrAt("|", nrBotEndSyntax, 16)
	
	vim.api.nvim_win_set_cursor(0, {15,0})
end

function DayWeekTemplateInsert()
	WeekTemplateInsert()
end

vim.cmd[[ command! -nargs=0 TodoNew :lua NewTodo() ]]
vim.cmd[[ command! -nargs=0 TodoDone :lua  BranchDone()]]
vim.cmd[[ command! -nargs=0 TodoWeekTemplate :lua DayWeekTemplateInsert()]]

return {
	ReplaceStrAt = ReplaceStrAt,
	Current_Day_Outline_to_Bold = Current_Day_Outline_to_Bold,
	NewTodo = NewTodo,
	BranchDone = BranchDone,
}
