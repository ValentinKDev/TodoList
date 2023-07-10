local numMonthEqFun = require 'vkdev.TodoList.functions.number_month_eq'
local systemVar = require 'vkdev.TodoList.variables.basic_variables'
local modifyLineFun = require 'vkdev.TodoList.functions.modify.line'

-- [[
-- Function to insert a new week day by day template and fill or replace "XX" "MMMM" "|" ";" "," 
-- elements by an accurate date and an elegante presentation
-- ]]
local function WeekTemplateInsert(dayNrInTheWeek, dayNrInTheMonth, monthNr)
	local weekTemplate = systemVar.weekTemplate
	local monthName = systemVar.monthName

	local file = io.open(weekTemplate, "r")
	if not weekTemplate then
		print("Failed to open source file: " .. weekTemplate)
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

	local startNr = dayNrInTheMonth - (dayNrInTheWeek - 1)
	local startStr = ""
	local minusMonth = false
	if startNr < 10 then
		startStr = "0" .. startNr
	elseif startNr < 1 then
		minusMonth = true
		startNr = numMonthEqFun.GetMonthMaxDays(monthNr - 1)
		startStr = startNr
	else
		startStr = startNr
	end
	modifyLineFun.ReplaceStrAt("XX", startStr, 15)
	print("startNr : " .. startNr)

	local startMonth = minusMonth and numMonthEqFun.GetMonthName(monthNr) or monthName
--	print("monthNr : " .. monthNr)
--	print("startmonth len : " .. startMonth:len())
	modifyLineFun.ReplaceStrAt("MMMMM", startMonth, 15)

	local nrStartSyntax = "━"
	local i = 0
	local startMonthLen = tonumber(startMonth:len())
	while i < startMonthLen do
		nrStartSyntax = nrStartSyntax .. "━"
		i = i + 1
	end
	modifyLineFun.ReplaceStrAt(";", nrStartSyntax, 14)
	modifyLineFun.ReplaceStrAt(";", nrStartSyntax, 16)


	local plusMonth = false
	local endNr = startNr + 6
	local endStr = ""
	if endNr < 10 then
		endStr = "0" .. endNr
	elseif endNr > numMonthEqFun.GetMonthMaxDays(tonumber(monthNr)) then
		plusMonth = true
		endNr = endNr - numMonthEqFun.GetMonthMaxDays(tonumber(monthNr))
		endStr = endNr
	else
		endStr = endNr
	end
	print("endStr : " .. endStr)
	modifyLineFun.ReplaceStrAt("YY", endStr, 15)
	local endMonth = plusMonth and numMonthEqFun.GetMonthName(tonumber(monthNr) + 1) or monthName
	modifyLineFun.ReplaceStrAt("mmmmm", endMonth, 15)

	local nrEndSyntax = "━"
	i = 0
	local endMonthLen = tonumber(endMonth:len())
	while i < endMonthLen do
		nrEndSyntax = nrEndSyntax .. "━"
		i = i + 1
	end
	modifyLineFun.ReplaceStrAt(",", nrStartSyntax, 14)
	modifyLineFun.ReplaceStrAt(",", nrStartSyntax, 16)

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
	modifyLineFun.ReplaceStrAt("|", nrTopEndSyntax, 14)
	modifyLineFun.ReplaceStrAt("|", nrMidSyntax, 15)
	modifyLineFun.ReplaceStrAt("|", nrBotEndSyntax, 16)
	
	vim.api.nvim_win_set_cursor(0, {15,0})
end

function NextWeekTemplate()
	local dayNrInTheWeek = systemVar.dayNrInTheWeek
	local dayNrInTheMonth = systemVar.dayNrInTheMonth
	local monthNr = systemVar.monthNr
	local startDayInTheMonth = dayNrInTheMonth - dayNrInTheWeek + 7
	if startDayInTheMonth > numMonthEqFun.GetMonthMaxDays(monthNr) then
		monthNr = monthNr - 1
		dayNrInTheMonth = numMonthEqFun.GetMonthMaxDays(monthNr) + startDayInTheMonth
	end

	WeekTemplateInsert(systemVar.dayNrInTheWeek, systemVar.dayNrInTheMonth, systemVar.monthNr)
end

function ThisWeekTemplate()
	WeekTemplateInsert(systemVar.dayNrInTheWeek, systemVar.dayNrInTheMonth, systemVar.monthNr)
end

vim.cmd[[ command! -nargs=0 TodoThisWeekTemplate :lua ThisWeekTemplate()]]
vim.cmd[[ command! -nargs=0 TodoNextWeekTemplate :lua NextWeekTemplate()]]
