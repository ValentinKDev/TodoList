function NewTodo()
	--_LineVar.ResetDaysLineVar()
	local currentLine = vim.api.nvim_win_get_cursor(0)[1]
	local buffer = _BufferFun.GetBufferIdByName(_SystemVar.weekTodoPath)
	local currentLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine - 1, currentLine, false)[1]
	local nextLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine, currentLine + 1, false)[1]
	local nextNextLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine + 1, currentLine + 2, false)[1]
	print("current : " .. currentLineContent)
	print("nextnext : " .. nextNextLineContent)

	if currentLineContent:find('└─ ') then
		_ModifyLineFun.ReplaceStrAt('└', '├', currentLine)
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {_SyntaxVar.end_branch_content})
	elseif nextLineContent:find('└─ ') then
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {_SyntaxVar.new_branch_content})
	elseif currentLineContent:find('├─ ') then
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {_SyntaxVar.new_branch_content})
	else
		for _, dayName in ipairs({
			_SyntaxVar.day1,
			_SyntaxVar.day2,
			_SyntaxVar.day3,
			_SyntaxVar.day4,
			_SyntaxVar.day5,
			_SyntaxVar.day6,
			_SyntaxVar.day7,
		}) do
 			if nextNextLineContent:find(dayName) then
	 			vim.api.nvim_buf_set_lines(0, currentLine, currentLine,false, {_SyntaxVar.end_branch_content})
			end
		end
	end
end

function BranchDone()
	local target_char = '─'
	local replacement_char = '✔'
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local currentLine = cursor_pos[1]
	local buffer = _BufferFun.GetBufferIdByName(_SystemVar.weekTodoPath)
	local lineContent = vim.api.nvim_buf_get_lines(buffer, currentLine - 1, currentLine, false)[1]
	if lineContent:find(replacement_char) then
		_ModifyLineFun.ReplaceStrAt(replacement_char, target_char, currentLine )
	else
		_ModifyLineFun.ReplaceStrAt(target_char, replacement_char, currentLine )
	end
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end


vim.cmd[[ command! -nargs=0 TodoNew :lua NewTodo() ]]
vim.cmd[[ command! -nargs=0 TodoDone :lua  BranchDone()]]

return {
	NewTodo = NewTodo,
	BranchDone = BranchDone,
}
