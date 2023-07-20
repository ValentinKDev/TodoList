local function Contains(table, number)
    for _, value in pairs(table) do if value == number then return true end end
    return false
end

return {
	Contains = Contains
}
