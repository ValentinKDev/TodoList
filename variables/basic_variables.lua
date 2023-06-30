local todoPath = "/home/vkdev/.todo/"
local weekTodoPath = todoPath .. "week.todo"
local nextTodoPath = todoPath .. "next"

local weekDay = os.date("%A")

return {
	nextTodoPath = nextTodoPath,
	todoPath = todoPath,
	weekTodoPath = weekTodoPath,
	weekDay = weekDay
}
