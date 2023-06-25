local function Find(word, filepath, start_line)
	local line_number = -1
	local file = io.open(filepath, "r")

	if not file then
		print("File not found: " .. filepath)
		return line_number
	end
	if (start_line < 1) then 
		print("Error Find start_line: " .. start_line)
	end
	local line_count = 1
	for line in file:lines() do
		if line_count > start_line then 
			if line:find(word) then
				line_number = line_count
				break
			end
		end
		line_count = line_count + 1
	end
	file:close()
	return line_number
end

return {
	Find = Find,
}
