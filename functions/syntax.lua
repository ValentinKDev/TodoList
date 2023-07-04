local NumDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'

vim.fn.matchadd("yellow2", "SEMAINE")
vim.fn.matchadd("yellow2", "#")
vim.fn.matchadd("yellow3", "═")
vim.fn.matchadd("yellow3", "║")
vim.fn.matchadd("yellow3", "╠")
vim.fn.matchadd("yellow3", "╔")
vim.fn.matchadd("yellow3", "╚")
vim.fn.matchadd("yellow3", "╗")
vim.fn.matchadd("yellow3", "╝")

vim.api.nvim_set_hl(0, "red", {fg='#aa0000' ,bg='#202020'})
vim.api.nvim_set_hl(0, "green", {fg='#00aa00'})
vim.api.nvim_set_hl(0, "yellow", {fg='#707000'})
vim.api.nvim_set_hl(0, "blue", {fg='#0070aa', bold=true})
vim.api.nvim_set_hl(0, "blueTop", {fg='#0070aa', bold=true})
vim.api.nvim_set_hl(0, "blueBot", {fg='#0070aa', bold=true})
vim.api.nvim_set_hl(0, "grayToHide", {fg='#656565'})
vim.api.nvim_set_hl(0, "yellow2", {fg='#bbaa00'})
vim.api.nvim_set_hl(0, "yellow3", {fg='#988500'})
vim.api.nvim_set_hl(0, "CursorLineNr", {bold=true, bg=Gray})

vim.cmd[[ hi Folded guifg=#656565 guibg=#282828 ]]
vim.cmd[[ hi FoldColumn guibg=#050505 ]]
vim.cmd[[ hi DayBranch guifg=#555555]]
--vim.cmd[[ match DayBranch /\s*\p✕.*\Z/ ]]
vim.cmd[[ match DayBranch /\s*\p✔.*\Z/ ]]

--local ?
local function Hightlight_Str_In_Gray(str) 
	vim.fn.matchadd("grayToHide", str) 
end

local function Hightlight_Str_In_Blue(str) 
	vim.fn.matchadd("blue", str) 
end

local function Fold_Between(startLine, endLine) 
	vim.cmd(string.format("%s,%sfo", startLine, endLine)) 
end

local function Highlight_Current_Day_By_Num(dayNum)
	local dayTopStr = NumDayEqFun.Get_Day_Top_String(dayNum)
	local dayStr = NumDayEqFun.Get_Day_String(dayNum)
	local dayBotStr = NumDayEqFun.Get_Day_Bot_String(dayNum)
	Hightlight_Str_In_Blue(dayStr)
	Hightlight_Str_In_Blue(dayTopStr)
	Hightlight_Str_In_Blue(dayBotStr)
end

return {
	Hightlight_Str_In_Blue = Hightlight_Str_In_Blue,
	Hightlight_Str_In_Gray = Hightlight_Str_In_Gray,
	Fold_Between = Fold_Between,
	Highlight_Current_Day_By_Num = Highlight_Current_Day_By_Num,
}
