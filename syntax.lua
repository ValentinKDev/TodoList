print("todo syntax")

local systemVar = require 'vkdev.plugins_config.TodoList.variables.basic_variables'
local syntaxVar = require 'vkdev.plugins_config.TodoList.variables.syntax_variables'

--local weekDay = os.date("%A")
--local todoPath = "/home/vkdev/.todo/week.todo"
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

local function ReplaceCharacterAt(target_char, replacement_char, line)
	local line_content = vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1]
	local updated_line_content = line_content:gsub(target_char, replacement_char)
	vim.api.nvim_buf_set_lines(0, line, line + 1, false, {updated_line_content})
end


function NewTodo()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local end_of_branch = Is_Line_Number_DayStr(current_line + 2)
	if end_of_branch == true then
		ReplaceCharacterAt('└', '├', current_line - 1)
		vim.api.nvim_buf_set_lines(0, current_line, current_line,false, {syntaxVar.end_branch_content})
	else 
		vim.api.nvim_buf_set_lines(0, current_line, current_line,false, {syntaxVar.new_branch_content})
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

vim.cmd[[ command! -nargs=0 TodoNew :lua NewTodo() ]]
vim.cmd[[ command! -nargs=0 TodoDone :lua  BranchDone()]]
vim.keymap.set("n", "<Leader>tn", ":TodoNew<CR>")
vim.keymap.set("n", "<Leader>td", ":TodoDone<CR>")

function Find_word_in_string_from_line(word, input_string, start_line)
	local line_count = 1
	for line in input_string:gmatch("[^\r\n]+") do
		if line_count >= start_line then
			if line:find(word) then
				return true
			end
		end
		line_count = line_count + 1
	end
	return false
end

function Find(word, filepath, start_line)
	local line_number = -1
	local file = io.open(filepath, "r")

	if not file then
		print("File not found: " .. filepath)
		return line_number
	end
	if (start_line < 1) then 
		print("Error Find start_line: " .. start_line)
	end
	local line_count = 1
	for line in file:lines() do
		if line_count > start_line then 
			if line:find(word) then
				line_number = line_count
				break
			end
		end
		line_count = line_count + 1
	end
	file:close()
	return line_number
end

local day1Line = Find("- Lundi -", systemVar.todoPath, 1)
local day2Line = Find("- Mardi -", systemVar.todoPath, 1)
local day3Line = Find("- Mercredi -", systemVar.todoPath, 1)
local day4Line = Find("- Jeudi -", systemVar.todoPath, 1)
local day5Line = Find("- Vendredi -", systemVar.todoPath, 1)
local day6Line = Find("- Samedi -", systemVar.todoPath, 1)
local day7Line = Find("- Dimanche -", systemVar.todoPath, 1)
local day1Start = day1Line + 2
local day2Start = day2Line + 2
local day3Start = day3Line + 2
local day4Start = day4Line + 2
local day5Start = day5Line + 2
local day6Start = day6Line + 2
local day7Start = day7Line + 2
local day1End = day2Line - 2
local day2End = day3Line - 2
local day3End = day4Line - 2
local day4End = day5Line - 2
local day5End = day6Line - 2
local day6End = day7Line - 2
local day7End = 0

local day1="┃ - Lundi - ┃"
local day2="┃ - Mardi - ┃"
local day3="┃ - Mercredi - ┃"
local day4="┃ - Jeudi - ┃"
local day5="┃ - Vendredi - ┃"
local day6="┃ - Samedi - ┃"
local day7="┃ - Dimanche - ┃"
local day1_Top_Outline="┏━━━━━━━━━━━┓   "
local day1_Bot_Outline="┗━┯━━━━━━━━━┛   "
local day2_Top_Outline="┏━━━━━━━━━━━┓  "
local day2_Bot_Outline="┗━┯━━━━━━━━━┛  "
local day3_Top_Outline="┏━━━━━━━━━━━━━━┓   "
local day3_Bot_Outline="┗━┯━━━━━━━━━━━━┛   "
local day4_Top_Outline="┏━━━━━━━━━━━┓ "
local day4_Bot_Outline="┗━┯━━━━━━━━━┛ "
local day5_Top_Outline="┏━━━━━━━━━━━━━━┓  "
local day5_Bot_Outline="┗━┯━━━━━━━━━━━━┛  "
local day6_Top_Outline="┏━━━━━━━━━━━━┓"
local day6_Bot_Outline="┗━┯━━━━━━━━━━┛"
local day7_Top_Outline="┏━━━━━━━━━━━━━━┓ "
local day7_Bot_Outline="┗━┯━━━━━━━━━━━━┛ "

 function Is_Line_Number_DayStr(line)
	local ret = false
	if line == day1Line then ret = true
	elseif line == day2Line then ret = true
	elseif line == day3Line then ret = true
	elseif line == day4Line then ret = true
	elseif line == day5Line then ret = true
	elseif line == day6Line then ret = true
	elseif line == day7Line then ret = true
	else ret = false
	end
--	local so = true
	--print("ret " .. so)
	return ret
end


local function DayToNum(dayX) 
	local dayNum = -1
	if dayX == "lundi" then dayNum = 1
	elseif dayX == "mardi" then dayNum = 2
	elseif dayX == "mercredi" then dayNum = 3
	elseif dayX == "jeudi" then dayNum = 4
	elseif dayX == "vendredi" then dayNum = 5
	elseif dayX == "samedi" then dayNum = 6
	elseif dayX == "dimanche" then dayNum = 7
	else dayNum = 0
	end
	return dayNum
end

local function Get_Day_Bot_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = day1_Bot_Outline
	elseif dayNum == 2 then str = day2_Bot_Outline
	elseif dayNum == 3 then str = day3_Bot_Outline
	elseif dayNum == 4 then str = day4_Bot_Outline
	elseif dayNum == 5 then str = day5_Bot_Outline
	elseif dayNum == 6 then str = day6_Bot_Outline
	elseif dayNum == 7 then str = day7_Bot_Outline
	else print("Error in Get_Day_Top_String")
	end
	return str
end

local function Get_Day_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = syntaxVar.day1_Middle
	elseif dayNum == 2 then str = syntaxVar.day2_Middle
	elseif dayNum == 3 then str = syntaxVar.day3_Middle
	elseif dayNum == 4 then str = syntaxVar.day4_Middle
	elseif dayNum == 5 then str = syntaxVar.day5_Middle
	elseif dayNum == 6 then str = syntaxVar.day6_Middle
	elseif dayNum == 7 then str = syntaxVar.day7_Middle
	else print("Error in Get_Day_String")
	end
	return str
end

local function Get_Day_String_line(dayNum)
	local line = ""
	if (dayNum == 1) then line = day1Line
	elseif dayNum == 2 then line = day2Line
	elseif dayNum == 3 then line = day3Line
	elseif dayNum == 4 then line = day4Line
	elseif dayNum == 5 then line = day5Line
	elseif dayNum == 6 then line = day6Line
	elseif dayNum == 7 then line = day7Line
	else print("Error in Get_Day_String_Line")
	end
	return line
end

local function Get_Day_Top_String(dayNum)
	local str = ""
	if (dayNum == 1) then str = day1_Top_Outline
	elseif dayNum == 2 then str = day2_Top_Outline
	elseif dayNum == 3 then str = day3_Top_Outline
	elseif dayNum == 4 then str = day4_Top_Outline
	elseif dayNum == 5 then str = day5_Top_Outline
	elseif dayNum == 6 then str = day6_Top_Outline
	elseif dayNum == 7 then str = day7_Top_Outline
	else print("Error in Get_Day_Top_String")
	end
	return str
end

local function Get_Day_List_Start_Line(dayNum) 
	local line = -1 
	if (dayNum == 1) then line = day1Start
	elseif dayNum == 2 then line = day2Start
	elseif dayNum == 3 then line = day3Start
	elseif dayNum == 4 then line = day4Start
	elseif dayNum == 5 then line = day5Start
	elseif dayNum == 6 then line = day6Start
	elseif dayNum == 7 then line = day7Start
	else print("Error in Get_Day_List_Start_Line")
	end
	return line
end

local function Get_Day_List_End_Line(dayNum) 
	local line = -1 
	if (dayNum == 1) then line = day1End
	elseif dayNum == 2 then line = day2End
	elseif dayNum == 3 then line = day3End
	elseif dayNum == 4 then line = day4End
	elseif dayNum == 5 then line = day5End
	elseif dayNum == 6 then line = day6End
	elseif dayNum == 7 then line = day7End
	else print("Error in Get_Day_List_End_Line")
	end
	return line
end

local function Hightlight_Str_In_Gray(str) vim.fn.matchadd("grayToHide", str) end
local function Hightlight_Str_In_Blue(str) vim.fn.matchadd("blue", str) end
local function Fold_Between(startLine, endLine) vim.cmd(string.format("%s,%sfo", startLine, endLine)) end

local function HideDay(dayNum)
	local dayTopStr = Get_Day_Top_String(dayNum)
	local dayStr = Get_Day_String(dayNum)
	local dayBotStr = Get_Day_Bot_String(dayNum)
	local dayStart = Get_Day_List_Start_Line(dayNum)
	local dayEnd = Get_Day_List_End_Line(dayNum)
	Hightlight_Str_In_Gray(dayTopStr)
	Hightlight_Str_In_Gray(dayStr)
	Hightlight_Str_In_Gray(dayBotStr)
	Fold_Between(dayStart, dayEnd)
	print(dayStr)
end

local function Highlight_Current_Day_By_Num(dayNum)
	local dayTopStr = Get_Day_Top_String(dayNum)
	local dayStr = Get_Day_String(dayNum)
	local dayBotStr = Get_Day_Bot_String(dayNum)
	Hightlight_Str_In_Blue(dayTopStr)
	Hightlight_Str_In_Blue(dayStr)
	Hightlight_Str_In_Blue(dayBotStr)
end

local function Move_Cursor_To_Current_List(dayNum) 
	local line = Get_Day_List_Start_Line(dayNum)
	local column = 8
	vim.api.nvim_win_set_cursor(0, {line, column})
end

local function Current_Day_Outline_to_Bold(dayNum)
	local day_str_line = Get_Day_String_line(dayNum)
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

local function Handle_current_Day(dayNum)
	Highlight_Current_Day_By_Num(dayNum)
	Move_Cursor_To_Current_List(dayNum)
	Current_Day_Outline_to_Bold(dayNum)
end

local function Hil(currentDay)
	local dayNum = DayToNum(currentDay)
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
