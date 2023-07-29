local todoPath = "/home/vkdev/.todo/"
local weekDir = "week/"
local monthDir = "month/"
local weekTemplate = todoPath .. weekDir .. "week_template"
local weekTodoPath = todoPath .. weekDir .. "week.todo"
local monthTodoPath = todoPath .. monthDir .. "month.todo"
local nextTodoPath = todoPath .. "next"

local TodoPlugPath = "/home/vkdev/.config/nvim/lua/vkdev/TodoList/"
local keymapLuaFilePath = TodoPlugPath .. "keymap.lua"
local weekLuaFilePath = TodoPlugPath .. "weeks.lua"
local monthLuaFilePath = TodoPlugPath .. "months.lua"
local funDirPath = TodoPlugPath .. "functions/"
local utilsFunFilePath = funDirPath .. "list.lua"
local modifyLuaDirPath = funDirPath .. "modify/"
local templateInsertLuaFilePath = modifyLuaDirPath .. "template.lua"
local modifyListLuaFilePath = modifyLuaDirPath .. "list.lua"

local weekDay = os.date("%A")
local dayNrInTheWeek = os.date("%w")
local dayNrInTheMonth = os.date("%d")
local monthNr = os.date("%m")
local monthName = os.date("%B")

return {
	nextTodoPath = nextTodoPath,
	todoPath = todoPath,
	weekTodoPath = weekTodoPath,
	monthTodoPath = monthTodoPath,
	weekDay = weekDay,
	monthNr = monthNr,
	dayNrInTheMonth = dayNrInTheMonth,
	dayNrInTheWeek = dayNrInTheWeek,
	monthName = monthName,
	weekTemplate = weekTemplate,
	keymapLuaFilePath = keymapLuaFilePath,
	weekLuaFilePath = weekLuaFilePath,
	monthLuaFilePath = monthLuaFilePath,
	templateInsertLuaFilePath = templateInsertLuaFilePath,
	modifyListLuaFilePath = modifyListLuaFilePath,
	utilsFunFilePath = utilsFunFilePath,
}
