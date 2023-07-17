-- Set the filetype to 'todo' for .todo files

local systemVar = require 'vkdev.TodoList.variables.basic_variables'

vim.cmd [[augroup custom_todo_week_filetypes]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufRead,BufNewFile week.todo setfiletype weektodo]]
vim.cmd [[augroup END]]

-- Load custom syntax for 'todo' filetype
vim.cmd [[augroup custom_todo_weeks_syntax]]
vim.cmd [[autocmd!]]
vim.api.nvim_command('autocmd FileType weektodo source ' .. systemVar.weekLuaFilePath)
vim.cmd [[augroup END]]

vim.cmd [[augroup custom_todo_week_filetypes2]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufRead,BufNewFile month.todo setfiletype monthtodo]]
vim.cmd [[augroup END]]
vim.cmd [[augroup custom_todo_months_syntax2]]
vim.cmd [[autocmd!]]
vim.api.nvim_command('autocmd FileType weektodo source ' .. systemVar.monthLuaFilePath)
vim.cmd [[augroup END]]

