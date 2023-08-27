--local _NumDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'

_VIM.fn.matchadd("yellow2", "SEMAINE")
_VIM.fn.matchadd("yellow2", "#")
_VIM.fn.matchadd("yellow3", "═")
_VIM.fn.matchadd("yellow3", "║")
_VIM.fn.matchadd("yellow3", "╠")
_VIM.fn.matchadd("yellow3", "╔")
_VIM.fn.matchadd("yellow3", "╚")
_VIM.fn.matchadd("yellow3", "╗")
_VIM.fn.matchadd("yellow3", "╝")

_VIM.api.nvim_set_hl(0, "red", {fg='#aa0000' ,bg='#202020'})
_VIM.api.nvim_set_hl(0, "green", {fg='#00aa00'})
_VIM.api.nvim_set_hl(0, "yellow", {fg='#707000'})
_VIM.api.nvim_set_hl(0, "blue", {fg='#0070aa', bold=true})
_VIM.api.nvim_set_hl(0, "blueTop", {fg='#0070aa', bold=true})
_VIM.api.nvim_set_hl(0, "blueBot", {fg='#0070aa', bold=true})
_VIM.api.nvim_set_hl(0, "grayToHide", {fg='#656565'})
_VIM.api.nvim_set_hl(0, "yellow2", {fg='#bbaa00'})
_VIM.api.nvim_set_hl(0, "yellow3", {fg='#988500'})
_VIM.api.nvim_set_hl(0, "CursorLineNr", {bold=true, bg=Gray})

_VIM.cmd[[ hi Folded guifg=#656565 guibg=#282828 ]]
_VIM.cmd[[ hi FoldColumn guibg=#050505 ]]
_VIM.cmd[[ hi DoneBranch guifg=#555555]]
--_VIM.cmd[[ hi NoneBranch guifg=#852510]]
--_VIM.cmd[[ match NoneBranch /\s*\p✕.*\Z/ ]]
--_VIM.cmd[[ match NoneBranch /\s*\px.*\Z/ ]]
_VIM.cmd[[ match DoneBranch /\s*\p✔.*\Z/ ]]

--local ?
local function Hightlight_Str_In_Gray(str)
	_VIM.fn.matchadd("grayToHide", str)
end

local function Hightlight_Str_In_Blue(str)
	_VIM.fn.matchadd("blue", str)
end

local function Fold_Between(startLine, endLine)
	_VIM.cmd(string.format("%s,%sfo", startLine, endLine))
end

local function Highlight_Current_Day_By_Num(dayNum)
	print("Highlight_Current_Day_By_Num " .. dayNum)
	local dayTopStr = _NumDayEqFun.Get_Day_Top_String(dayNum)
	local dayStr = _NumDayEqFun.Get_Day_String(dayNum)
	local dayBotStr = _NumDayEqFun.Get_Day_Bot_String(dayNum)
	print(dayTopStr)
	print(dayStr)
	print(dayBotStr)
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
