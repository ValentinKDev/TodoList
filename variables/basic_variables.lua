local todoPath = "/home/vkdev/.todo/"
local weekDir = "week/"
local weekTemplate = todoPath .. weekDir .. "week_template"
local weekTodoPath = todoPath .. "week.todo"
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

--[[local NumDayEqFun = require 'vkdev.TodoList.functions.number_day_eq'

local stt = (NumDayEqFun.DayToNum(weekDay))
print("stt : " .. stt)
local str = dayNr
print("str : " .. str)
local startNr = dayNr - (NumDayEqFun.DayToNum(weekDay) - 1)
print("startNr : " .. startNr)
local startStr = ""
if startNr < 10 then startStr = "0" .. startNr else startStr = startStr end
print("startStr : " .. startStr)
]]

return {
	nextTodoPath = nextTodoPath,
	todoPath = todoPath,
	weekTodoPath = weekTodoPath,
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
