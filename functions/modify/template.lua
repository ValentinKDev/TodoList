print("load functions/modify/template.lua")

-- [[
-- Function to insert a new week day by day template and fill or replace "XX" "MMMM" "|" ";" "," 
-- elements by an accurate date and an elegante presentation
-- ]]
local function WeekTemplateInsert(dayNrInTheWeek, dayNrInTheMonth, monthNr)
	local weekTemplate = _SystemVar.weekTemplate
	local monthName = _SystemVar.monthName

	local file = io.open(weekTemplate, "r")
	if file == nil then
		print("Failed to open source file: " .. weekTemplate)
		return
	end
	if not weekTemplate then
		print("Failed to open source file: " .. weekTemplate)
		return
	end
	local startLineNumber = 10
	local lineCount = 1
	for line in file:lines() do
		lineCount = lineCount + 1
		local lineNumber = startLineNumber + lineCount
		_VIM.api.nvim_buf_set_lines(0, lineNumber , lineNumber, false, {line})
	end
	file:close()

	local i = 0

	local startNr = dayNrInTheMonth - (dayNrInTheWeek - 1)
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
	_ModifyLineFun.ReplaceStrAt("MMMMM", startMonth, 15)

	local startMonthOutlineSymbol = "━"
	local startMonthLen = tonumber(startMonth:len())
	local startMonthOutlineLen = 4 + 1 + 2 + 2 + 1 + startMonthLen - 1 + 2 + 1 + 4 -1
	for j = 1, startMonthOutlineLen, 1 do 
		startMonthOutlineSymbol = startMonthOutlineSymbol .. "━"
	end
	_ModifyLineFun.ReplaceStrAt(";", startMonthOutlineSymbol, 14)
	_ModifyLineFun.ReplaceStrAt(";", startMonthOutlineSymbol, 16)
	print("start len : " .. startMonthLen)


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

	if tonumber(endStr) < 10 then endStr = "0"..endStr end
	_ModifyLineFun.ReplaceStrAt("YY", endStr, 15)
	local endMonth = plusMonth and _NumMonthEqFun.GetMonthName(tonumber(monthNr) + 1) or monthName
	_ModifyLineFun.ReplaceStrAt("mmmmm", endMonth, 15)

	local endMonthOutlineSymbol = "━"
	local endMonthLen = tonumber(endMonth:len())
	local endMonthOutlineLen = 4 + 1 + 2 + 2 + 1 + endMonthLen - 1 + 2 + 1 + 4
	for j = 1, endMonthOutlineLen, 1 do 
		endMonthOutlineSymbol = endMonthOutlineSymbol .. "━"
	end
	_ModifyLineFun.ReplaceStrAt(",", endMonthOutlineSymbol, 14)
	_ModifyLineFun.ReplaceStrAt(",", endMonthOutlineSymbol, 16)

	local nrTopEndSyntax = ""
	local nrMidSyntax = ""
	local nrBotEndSyntax = ""
	local len = 1 + 142 - 123 + 2 * 4 - startMonthLen - endMonthLen
	for j = 1, len, 1 do 
		nrMidSyntax = nrMidSyntax .. "═"
		nrBotEndSyntax = nrBotEndSyntax .. " "
		nrTopEndSyntax = nrTopEndSyntax .. ":"
	end
	_ModifyLineFun.ReplaceStrAt("|", nrTopEndSyntax, 14)
	_ModifyLineFun.ReplaceStrAt("|", nrMidSyntax, 15)
	_ModifyLineFun.ReplaceStrAt("|", nrBotEndSyntax, 16)
	
	_VIM.api.nvim_win_set_cursor(0, {15,0})
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

_VIM.cmd[[ command! -nargs=0 TodoThisWeekTemplate :lua ThisWeekTemplate()]]
_VIM.cmd[[ command! -nargs=0 TodoNextWeekTemplate :lua NextWeekTemplate()]]
