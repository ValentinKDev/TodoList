--local _SystemVar = require 'vkdev.TodoList.variables.basic_variables'
--local _BufferFun = require 'vkdev.TodoList.functions.buffers'

local border_buf_path = _SystemVar.todoPath .. "border_buf"
local border_buf_name = border_buf_path

local calcul_width = math.floor(_VIM.o.columns * 0.8)
local width = calcul_width < 104 and calcul_width or 104
local height = math.floor(_VIM.o.lines * 0.8)
local row = math.floor((_VIM.o.lines - height) / 2)
local col = math.floor((_VIM.o.columns - width) / 2)

local function GetBufferNumberByName(bufferName)
	local existing_buf = -1
	for _, bufferNumber in ipairs(_VIM.api.nvim_list_bufs()) do
		if _VIM.api.nvim_buf_get_name(bufferNumber) == bufferName then
			existing_buf = bufferNumber
			break
		end
	end

	print("GetBufferNumberByName() : " .. existing_buf)
	return existing_buf
end

function OpenBorderedWindow()
	local existing_buf = GetBufferNumberByName(border_buf_name)
	local content_buf = existing_buf == -1 and _VIM.api.nvim_create_buf(false, true) or existing_buf
	if existing_buf == -1 then _VIM.api.nvim_buf_set_name(content_buf, border_buf_name) end
	local border_ns = _VIM.api.nvim_create_namespace("MyBorder")
	local opts = {
		style = "minimal",
		relative = "editor",
		width = width + 4,
		height = height + 2,
		row = row - 1,
		col = col - 2,
	}
	local border_chars = {'╔','═', '╗','║', '╝','═', '╚', '║' }
	local border_lines = {"╔" .. string.rep("═", width + 2) .. "╗"}
	for _ = 1, height do
		table.insert(border_lines, "║" .. string.rep(" ", width + 2) .. "║")
	end
	table.insert(border_lines, "╚" .. string.rep("═", width + 2) .. "╝")
	_VIM.api.nvim_buf_set_lines(content_buf, 0, -1, false, border_lines)
	local win = _VIM.api.nvim_open_win(content_buf, true, opts)
	_VIM.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal')
end

function OpenFileInWindow(file_path)
	local existing_buf = GetBufferNumberByName(border_buf_name)
	local content_buf = existing_buf == -1 and _VIM.api.nvim_create_buf(false, true) or existing_buf

	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
	}
	local win = _VIM.api.nvim_open_win(content_buf, true, opts)
	_VIM.api.nvim_command("highlight FloatBackground guibg=black")
	_VIM.api.nvim_win_set_option(win, "winhighlight", "FloatBackground:NormalFloat")
	_VIM.api.nvim_command("edit" .. file_path)
	_VIM.api.nvim_win_set_option(win, 'winhl', 'Normal:Normal')

end

function OpenWindowForListOfTodoThing()
	OpenBorderedWindow()
	OpenFileInWindow(_SystemVar.nextTodoPath)
end

function OpenWindowHelpTodoCommands()
	OpenBorderedWindow()
	OpenFileInWindow(_SystemVar.keymapLuaFilePath)
end

function CloseBorderIfFloatingWin()
	local is_buf_floating_win = _BufferFun.IsCurrentBuffer(_SystemVar.nextTodoPath)
	if is_buf_floating_win then
		local bufNr = _BufferFun.GetBufferIdByName(border_buf_name)
		_VIM.api.nvim_buf_delete(bufNr, { force = true })
	end
end

_VIM.cmd [[augroup custom_todo_file_quiting]]
_VIM.cmd [[autocmd!]]
_VIM.cmd [[autocmd BufLeave * lua CloseBorderIfFloatingWin()]]
_VIM.cmd [[autocmd BufLeave, BufWinLeave, BufWipeout next setfiletype monthtodo]]
_VIM.cmd [[augroup END]]

_VIM.cmd[[ command! -nargs=0 TodoBorderWindow :lua OpenBorderedWindow()]]
_VIM.cmd[[ command! -nargs=0 OpenListTodoThings :lua OpenWindowForListOfTodoThing()]]
_VIM.cmd[[ command! -nargs=0 OpenHelpWindow :lua OpenWindowHelpTodoCommands()]]
_VIM.cmd[[ command! -nargs=0 TodoHelp :lua TodoHelp()]]
