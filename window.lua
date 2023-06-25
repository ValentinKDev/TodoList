--print("window")
function PrintBuff()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		print("bufnr : " .. bufnr .. vim.api.nvim_buf_get_name(bufnr))
	end
end
function OpenFloatingWindow()
	local syntax_path = "~/.config/nvim/lua/vkdev/plugins_config/todo_plug/syntax.lua"
	local file_path = "~/.todo/week.todo"

	local existing_buf = -1
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--		print("bufnr : " .. bufnr .. vim.api.nvim_buf_get_name(bufnr))
		if vim.api.nvim_buf_get_name(bufnr) == file_path then
			existing_buf = bufnr
			break
		end
	end

	print("existing_buf : " .. existing_buf)
	-- Create a new buffer or use the existing one
	local content_buf = existing_buf == -1 and vim.api.nvim_create_buf(false, true) or existing_buf

	-- If it's a new buffer, set its name and open the file in it
	if existing_buf == -1 then
		vim.api.nvim_buf_set_name(content_buf, file_path)
		vim.api.nvim_buf_call(content_buf, function()
			vim.api.nvim_command("edit " .. file_path)
		end)
	end

	-- Calculate the size and position of the floating window
	local calcul_width = math.floor(vim.o.columns * 0.8)
	local width = calcul_width < 104 and calcul_width or 104
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create a new highlight group for the border
	local border_ns = vim.api.nvim_create_namespace("MyBorder")


	-- Create the floating window
	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
	}
	local win = vim.api.nvim_open_win(content_buf, true, opts)
	--local win = vim.api.nvim_open_win(13, true, opts)
	vim.api.nvim_command("edit" .. file_path)
	vim.api.nvim_win_set_option(win, "wrap", false)
	vim.api.nvim_win_set_option(win, "cursorline", true)
	vim.api.nvim_win_set_option(win, "number", true)
	vim.api.nvim_win_set_option(win, "relativenumber", true)
	vim.api.nvim_command("source " .. syntax_path )


	-- Set the floating window background to be the same as Neovim background
	vim.api.nvim_command("highlight link MyFloatingWindowBG Normal")
	vim.api.nvim_win_set_option(win, "winhl", "Normal:MyFloatingWindowBG")


	-- Create a new buffer for the border
	local border_buf = vim.api.nvim_create_buf(false, true)
	local border_buf_name = "border_buf"
	vim.api.nvim_buf_set_name(border_buf, border_buf_name)

	-- Draw the border in the border buffer
	local border_chars = {'╔','═', '╗','║', '╝','═', '╚', '║' }
	local border_width = width
	local border_lines = {"╔" .. string.rep("═", border_width) .. "╗"}
	for _ = 1, height do
		table.insert(border_lines, "║" .. string.rep(" ", border_width) .. "║")
	end
	table.insert(border_lines, "╚" .. string.rep("═", border_width) .. "╝")
	vim.api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

	-- Create the border window
	local border_opts = {
		style = "minimal",
		relative = "editor",
		width = border_width + 2,
		height = height + 2,
		row = row - 1,
		col = col - 1,
	}
	--border =border_chars,
	local border_win = vim.api.nvim_open_win(border_buf, false, border_opts)
	-- Apply the custom border highlight group to the border buffer
	vim.api.nvim_win_set_option(border_win, "winhl", "Normal:MyBorder")
	vim.api.nvim_command("highlight link MyFloatingBorderWindowBG Normal")
	--vim.api.nvim_command("highlight link MyFloatingBorderWindowBG guibg=NONE")
	vim.api.nvim_win_set_option(border_win, "winhl", "Normal:MyFloatingBorderWindowBG")
--	vim.cmd("highlight NormalFloat guibg=NONE")
	local win_id = vim.fn.win_getid(content_win)
--	vim.cmd("autocmd BufWinLeave <buffer=" .. content_buf .. "> if winnr(" .. win_id .. ") == -1 | exe 'bwipeout!' " .. border_buf .. " | endif")
--	vim.cmd("autocmd BufWipeout <buffer=" .. content_buf .. "> if winnr(" .. win_id .. ") == -1 | exe 'bwipeout!' " .. border_buf .. " | endif")

end
