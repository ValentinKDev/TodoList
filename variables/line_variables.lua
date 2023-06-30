local readingFun = require 'vkdev.plugins_config.TodoList.functions.reading_file'
local systemVar = require 'vkdev.plugins_config.TodoList.variables.basic_variables'
--local readingFun = ReadingFun()
--local systemVar = SystemVar()
local day1Line = readingFun.Find("- Lundi -", systemVar.todoPath, 1)
local day2Line = readingFun.Find("- Mardi -", systemVar.todoPath, 1)
local day3Line = readingFun.Find("- Mercredi -", systemVar.todoPath, 1)
local day4Line = readingFun.Find("- Jeudi -", systemVar.todoPath, 1)
local day5Line = readingFun.Find("- Vendredi -", systemVar.todoPath, 1)
local day6Line = readingFun.Find("- Samedi -", systemVar.todoPath, 1)
local day7Line = readingFun.Find("- Dimanche -", systemVar.todoPath, 1)

local day1LineStart = day1Line + 2
local day2LineStart = day2Line + 2
local day3LineStart = day3Line + 2
local day4LineStart = day4Line + 2
local day5LineStart = day5Line + 2
local day6LineStart = day6Line + 2
local day7LineStart = day7Line + 2
local day1LineEnd = day2Line - 2
local day2LineEnd = day3Line - 2
local day3LineEnd = day4Line - 2
local day4LineEnd = day5Line - 2
local day5LineEnd = day6Line - 2
local day6LineEnd = day7Line - 2
local day7LineEnd = 0

return {
	day1Line = day1Line,
	day2Line = day2Line,
	day3Line = day3Line,
	day4Line = day4Line,
	day5Line = day5Line,
	day6Line = day6Line,
	day7Line = day7Line,

	day1LineStart = day1LineStart,
	day2LineStart = day2LineStart,
	day3LineStart = day3LineStart,
	day4LineStart = day4LineStart,
	day5LineStart = day5LineStart,
	day6LineStart = day6LineStart,
	day7LineStart = day7LineStart,
	day1LineEnd = day1LineEnd,
	day2LineEnd = day2LineEnd,
	day3LineEnd = day3LineEnd,
	day4LineEnd = day4LineEnd,
	day5LineEnd = day5LineEnd,
	day6LineEnd = day6LineEnd,
	day7LineEnd = day7LineEnd,
}
