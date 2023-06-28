local function Hightlight_Str_In_Gray(str) 
	vim.fn.matchadd("grayToHide", str) 
end

local function Hightlight_Str_In_Blue(str) 
	vim.fn.matchadd("blue", str) 
end

local function Fold_Between(startLine, endLine) 
	vim.cmd(string.format("%s,%sfo", startLine, endLine)) 
end

return {
	Hightlight_Str_In_Blue = Hightlight_Str_In_Blue,
	Hightlight_Str_In_Gray = Hightlight_Str_In_Gray,
	Fold_Between = Fold_Between,
}
