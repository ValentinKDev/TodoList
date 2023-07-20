print("load functions/read/file.lua")

local function Find(word, filePath, startLine)
	local lineNumber = -1
	local file = io.open(filePath, "r")

	if not file then
		print("File not found: " .. filePath)
		return lineNumber
	end
	if (startLine < 1) then
		print("Error Find startLine: " .. startLine)
	end
	local lineCount = 1
	for line in file:lines() do
		if lineCount > startLine then
			if line:find(word) then
				lineNumber = lineCount
				break
			end
		end
		lineCount = lineCount + 1
	end
	file:close()
	return lineNumber
end

local function Find_word_in_string_from_line(word, input_string, startLine)
	local lineCount = 1
	for line in input_string:gmatch("[^\r\n]+") do
		if lineCount >= startLine then
			if line:find(word) then
				return true
			end
		end
		lineCount = lineCount + 1
	end
	return false
end

--local function IsLineNumberDayStr(line)
--	local ret = false
--	if line == _LineVar.day1Line then ret = true
--	elseif line == _LineVar.day2Line then ret = true
--	elseif line == _LineVar.day3Line then ret = true
--	elseif line == _LineVar.day4Line then ret = true
--	elseif line == _LineVar.day5Line then ret = true
--	elseif line == _LineVar.day6Line then ret = true
--	elseif line == _LineVar.day7Line then ret = true
--	else ret = false
--	end
--	return ret
--end

return {
	Find = Find,
	Find_word_in_string_from_line = Find_word_in_string_from_line,
--	IsLineNumberDayStr = IsLineNumberDayStr
}
