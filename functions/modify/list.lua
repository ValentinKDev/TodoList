function NewTodoPrecedentLine()
	local stop = false
	local current_win = vim.api.nvim_get_current_win()
	local currentLine = vim.api.nvim_win_get_cursor(0)[1]
	local precedentLine = currentLine - 1
	local buffer = _BufferFun.GetBufferIdByName(_SystemVar.weekTodoPath)
	local currentLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine - 1, currentLine, false)[1]

	local precedentLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine - 2, currentLine - 1, false)[1]
	local beforePrecedentLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine - 3, currentLine - 2, false)[1]

	print("precedentLine : " .. precedentLineContent)
	if precedentLineContent:find('└─┬') or precedentLineContent:find('┗━┯') then
		print("1")
		vim.api.nvim_buf_set_lines(0, precedentLine, precedentLine, false, {_SyntaxVar.new_branch_content})
	elseif precedentLineContent:find('├─ ') then
		print("2")
		vim.api.nvim_buf_set_lines(0, precedentLine, precedentLine, false, {_SyntaxVar.new_branch_content})
	elseif precedentLineContent:find('└─ ') then
		print("3")
		_ModifyLineFun.ReplaceStrAt('└', '├', precedentLine)
		vim.api.nvim_buf_set_lines(0, precedentLine, precedentLine, false, {_SyntaxVar.end_branch_content})
	else
		print("4")
		stop = true
	end

	if stop == false then
		vim.api.nvim_win_set_cursor(current_win, {currentLine, 0})
		vim.api.nvim_feedkeys("A", "n", false)
	end
end

function NewTodoNextLine()
	local currentLine = vim.api.nvim_win_get_cursor(0)[1]
	local buffer = _BufferFun.GetBufferIdByName(_SystemVar.weekTodoPath)
	local currentLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine - 1, currentLine, false)[1]
	local nextLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine, currentLine + 1, false)[1]
	local nextNextLineContent = vim.api.nvim_buf_get_lines(buffer, currentLine + 1, currentLine + 2, false)[1]

	if currentLineContent:find('└─ ') then
		_ModifyLineFun.ReplaceStrAt('└', '├', currentLine)
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine, false, {_SyntaxVar.end_branch_content})
	elseif nextLineContent:find('├─ ') then
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine, false, {_SyntaxVar.new_branch_content})
	elseif nextLineContent:find('└─ ') then
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine, false, {_SyntaxVar.new_branch_content})
	elseif currentLineContent:find('└✔ ') then
		_ModifyLineFun.ReplaceStrAt('└', '├', currentLine)
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine, false, {_SyntaxVar.end_branch_content})
	elseif currentLineContent:find('├─ ') then
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine, false, {_SyntaxVar.new_branch_content})
	elseif currentLineContent:find('├✔ ') then
		vim.api.nvim_buf_set_lines(0, currentLine, currentLine, false, {_SyntaxVar.new_branch_content})
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
	vim.api.nvim_feedkeys("j", "n", false)
	vim.api.nvim_feedkeys("A", "n", false)
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


vim.cmd[[ command! -nargs=0 TodoNewBefore :lua NewTodoPrecedentLine() ]]
vim.cmd[[ command! -nargs=0 TodoNewNext :lua NewTodoNextLine() ]]
vim.cmd[[ command! -nargs=0 TodoDone :lua  BranchDone()]]

return {
	NewTodo = NewTodo,
	BranchDone = BranchDone,
}
