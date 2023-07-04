local todoPath = "/home/vkdev/.todo/"
local weekDir = "week/"
local dayTemplate = todoPath .. weekDir .. "week_template"
local weekTodoPath = todoPath .. "week.todo"
local nextTodoPath = todoPath .. "next"
local TodoPlugPath = "/home/vkdev/.config/nvim/lua/vkdev/TodoList/"
local keymapLuaFilePath = TodoPlugPath .. "keymap.lua"
local weekLuaFilePath = TodoPlugPath .. "weeks.lua"
local monthLuaFilePath = TodoPlugPath .. "months.lua"

local weekDay = os.date("%A")

return {
	nextTodoPath = nextTodoPath,
	todoPath = todoPath,
	weekTodoPath = weekTodoPath,
	weekDay = weekDay,
	dayTemplate = dayTemplate,
	keymapLuaFilePath = keymapLuaFilePath,
	weekLuaFilePath = weekLuaFilePath,
	monthLuaFilePath = monthLuaFilePath,
}
