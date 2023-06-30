-- Set the filetype to 'todo' for .todo files
vim.cmd [[augroup custom_todo_week_filetypes]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufRead,BufNewFile week.todo setfiletype weektodo]]
vim.cmd [[autocmd BufRead,BufNewFile month.todo setfiletype monthtodo]]
vim.cmd [[augroup END]]

-- Load custom syntax for 'todo' filetype
vim.cmd [[augroup custom_todo_weeks_syntax]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd FileType weektodo source ~/.config/nvim/lua/vkdev/plugins_config/TodoList/weeks.lua]]
--vim.cmd [[autocmd FileType todo source ~/.config/nvim/lua/vkdev/plugins_config/todo_plug/window.lua]]
vim.cmd [[augroup END]]

vim.cmd [[augroup custom_todo_months_syntax]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd FileType monthtodo source ~/.config/nvim/lua/vkdev/plugins_config/TodoList/months.lua]]
vim.cmd [[augroup END]]

