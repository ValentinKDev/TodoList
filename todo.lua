-- Set the filetype to 'todo' for .todo files
vim.cmd [[augroup custom_filetypes]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufRead,BufNewFile *.todo setfiletype todo]]
vim.cmd [[augroup END]]

-- Load custom syntax for 'todo' filetype
vim.cmd [[augroup custom_todo_syntax]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd FileType todo source ~/.config/nvim/lua/vkdev/plugins_config/TodoList/syntax.lua]]
--vim.cmd [[autocmd FileType todo source ~/.config/nvim/lua/vkdev/plugins_config/todo_plug/window.lua]]
vim.cmd [[augroup END]]

