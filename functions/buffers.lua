local function Get_buffers(options)
    local buffers = {}
    for buffer = 1, _VIM.fn.bufnr('$') do
        local is_listed = _VIM.fn.buflisted(buffer) == 1
        if options.listed and is_listed then
            table.insert(buffers, buffer)
        else
            table.insert(buffers, buffer)
        end
    end

    return buffers
end

function Print_Buffers()
	for _, bufnr in ipairs(_VIM.api.nvim_list_bufs()) do
		print("bufnr : " .. bufnr .. _VIM.api.nvim_buf_get_name(bufnr))
	end
end

local function IsCurrentBuffer(bufferName)
	local is_current_buf = false
	local current_buf_nr = _VIM.api.nvim_get_current_buf()
	local current_buf = _VIM.api.nvim_buf_get_name(current_buf_nr)

	if current_buf == bufferName then
		is_current_buf = true
	end
	return is_current_buf
end

function GetBufferIdByName(bufferName)
	local retNr = -1
	for _, bufNr in ipairs(_VIM.api.nvim_list_bufs()) do
		local name = _VIM.api.nvim_buf_get_name(bufNr)
        if name == bufferName then
			retNr = bufNr
        end
	end
	return retNr
end

_VIM.cmd[[ command! -nargs=0 TodoBuffers :lua IsCurrentBuffer()]]

return {
	PrintBuff = Get_buffers,
	IsCurrentBuffer = IsCurrentBuffer,
	GetBufferIdByName = GetBufferIdByName,
}
