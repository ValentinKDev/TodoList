print("load functions/modify/template.lua")
--local _NumMonthEqFun = require 'vkdev.TodoList.functions.number_month_eq'
--local _SystemVar = require 'vkdev.TodoList.variables.basic_variables'
--local _ModifyLineFun = require 'vkdev.TodoList.functions.modify.line'

-- [[
-- Function to insert a new week day by day template and fill or replace "XX" "MMMM" "|" ";" "," 
-- elements by an accurate date and an elegante presentation
-- ]]
local function WeekTemplateInsert(dayNrInTheWeek, dayNrInTheMonth, monthNr)
	local weekTemplate = _SystemVar.weekTemplate
	local monthName = _SystemVar.monthName

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
	print("startNr : " .. startNr)
	print("dayMonth : " .. dayNrInTheMonth)
	print("dayNrInTheWeek : " .. dayNrInTheWeek)
	local startStr = ""
	local minusMonth = false
	if startNr < 10 then
		startStr = "0" .. startNr
	elseif startNr < 1 then
		minusMonth = true
		startNr = _NumMonthEqFun.GetMonthMaxDays(monthNr - 1)
		startStr = startNr
	else
		startStr = startNr
	end
	_ModifyLineFun.ReplaceStrAt("XX", startStr, 15)

	local startMonth = minusMonth and _NumMonthEqFun.GetMonthName(monthNr) or monthName
--	print("monthNr : " .. monthNr)
--	print("startmonth len : " .. startMonth:len())
	_ModifyLineFun.ReplaceStrAt("MMMMM", startMonth, 15)

	local nrStartSyntax = "━"
	local i = 0
	local startMonthLen = tonumber(startMonth:len())
	while i < startMonthLen do
		nrStartSyntax = nrStartSyntax .. "━"
		i = i + 1
	end
	_ModifyLineFun.ReplaceStrAt(";", nrStartSyntax, 14)
	_ModifyLineFun.ReplaceStrAt(";", nrStartSyntax, 16)


	local plusMonth = false
	local endNr = startNr + 6
	local endStr = ""
	if endNr < 10 then
		endStr = "0" .. endNr
	elseif endNr > _NumMonthEqFun.GetMonthMaxDays(tonumber(monthNr)) then
		plusMonth = true
		endNr = endNr - _NumMonthEqFun.GetMonthMaxDays(tonumber(monthNr))
		endStr = endNr
	else
		endStr = endNr
	end
	_ModifyLineFun.ReplaceStrAt("YY", endStr, 15)
	local endMonth = plusMonth and _NumMonthEqFun.GetMonthName(tonumber(monthNr) + 1) or monthName
	_ModifyLineFun.ReplaceStrAt("mmmmm", endMonth, 15)

	local nrEndSyntax = "━"
	i = 0
	local endMonthLen = tonumber(endMonth:len())
	while i < endMonthLen do
		nrEndSyntax = nrEndSyntax .. "━"
		i = i + 1
	end
	_ModifyLineFun.ReplaceStrAt(",", nrStartSyntax, 14)
	_ModifyLineFun.ReplaceStrAt(",", nrStartSyntax, 16)

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
	_ModifyLineFun.ReplaceStrAt("|", nrTopEndSyntax, 14)
	_ModifyLineFun.ReplaceStrAt("|", nrMidSyntax, 15)
	_ModifyLineFun.ReplaceStrAt("|", nrBotEndSyntax, 16)
	
	vim.api.nvim_win_set_cursor(0, {15,0})
end

function NextWeekTemplate()
	local dayNrInTheWeek = _SystemVar.dayNrInTheWeek
	local dayNrInTheMonth = _SystemVar.dayNrInTheMonth
	local monthNr = _SystemVar.monthNr
	local nextWeekStartDayInTheMonth = dayNrInTheMonth - dayNrInTheWeek + 1 + 7
	if nextWeekStartDayInTheMonth > _NumMonthEqFun.GetMonthMaxDays(tonumber(monthNr)) then
		monthNr = monthNr - 1
		dayNrInTheMonth = _NumMonthEqFun.GetMonthMaxDays(tonumber(monthNr)) + nextWeekStartDayInTheMonth
	end

	WeekTemplateInsert(1, nextWeekStartDayInTheMonth, monthNr)
end

function ThisWeekTemplate()
	WeekTemplateInsert(_SystemVar.dayNrInTheWeek, _SystemVar.dayNrInTheMonth, _SystemVar.monthNr)
end

vim.cmd[[ command! -nargs=0 TodoThisWeekTemplate :lua ThisWeekTemplate()]]
vim.cmd[[ command! -nargs=0 TodoNextWeekTemplate :lua NextWeekTemplate()]]
