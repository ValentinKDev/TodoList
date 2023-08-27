local function ReplaceStrAt(targetStr, replacementStr, line)
	--local lineContent = vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1]
	--local updatedLineContent = lineContent:gsub(targetStr, replacementStr)
	--vim.api.nvim_buf_set_lines(0, line, line + 1, false, {updatedLineContent})
--	print("replaceStrAt : ")
--	print(targetStr) 
--	print(replacementStr) 
--	print(line) 
	local lineContent = vim.api.nvim_buf_get_lines(1, line - 1, line, false)[1]
	local updatedLineContent = lineContent:gsub(targetStr, replacementStr)
	vim.api.nvim_buf_set_lines(1, line - 1, line, false, {updatedLineContent})
end

return {
	ReplaceStrAt = ReplaceStrAt,
}
