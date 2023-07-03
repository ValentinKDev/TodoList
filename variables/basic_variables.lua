local todoPath = "/home/vkdev/.todo/"
local weekDir = "week/"
local dayTemplate = todoPath .. weekDir .. "week_template"
local weekTodoPath = todoPath .. "week.todo"
local nextTodoPath = todoPath .. "next"

local weekDay = os.date("%A")

return {
	nextTodoPath = nextTodoPath,
	todoPath = todoPath,
	weekTodoPath = weekTodoPath,
	weekDay = weekDay,
	dayTemplate = dayTemplate,
}
