function PrintBuffers()
	for _, bufnr in ipairs(_VIM.api.nvim_list_bufs()) do
		print("bufnr : " .. bufnr .. _VIM.api.nvim_buf_get_name(bufnr))
	end
end

local function IsCurrentBuffer(bufferName)
	local isCurrentBuf = false
	local currentBufNr = _VIM.api.nvim_get_current_buf()
	local currentBuf = _VIM.api.nvim_buf_get_name(currentBufNr)

	if currentBuf == bufferName then
		isCurrentBuf = true
	end
	return isCurrentBuf
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
	IsCurrentBuffer = IsCurrentBuffer,
	GetBufferIdByName = GetBufferIdByName,
}
