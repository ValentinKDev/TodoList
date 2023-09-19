-- Set the filetype to 'todo' for .todo files

local systemVar = require 'vkdev.TodoList.variables.basic_variables'

_VIM.cmd [[augroup custom_todo_week_filetypes]]
_VIM.cmd [[autocmd!]]
_VIM.cmd [[autocmd BufRead,BufNewFile week.todo setfiletype weektodo]]
_VIM.cmd [[augroup END]]

-- Load custom syntax for 'todo' filetype
_VIM.cmd [[augroup custom_todo_weeks_syntax]]
_VIM.cmd [[autocmd!]]
_VIM.api.nvim_command('autocmd FileType weektodo source ' .. systemVar.weekLuaFilePath)
_VIM.cmd [[augroup END]]

_VIM.cmd [[augroup custom_todo_week_filetypes2]]
_VIM.cmd [[autocmd!]]
_VIM.cmd [[autocmd BufRead,BufNewFile month.todo setfiletype monthtodo]]
_VIM.cmd [[augroup END]]

_VIM.cmd [[augroup custom_todo_months_syntax2]]
_VIM.cmd [[autocmd!]]
_VIM.api.nvim_command('autocmd FileType weektodo source ' .. systemVar.monthLuaFilePath)
_VIM.cmd [[augroup END]]

