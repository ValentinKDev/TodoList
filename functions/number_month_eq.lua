local function GetMonthMaxDays(monthNr)
	local maxDays = -1
	if monthNr == 1 then maxDays = 31
	elseif monthNr == 2 then maxDays = 28
	elseif monthNr == 3 then maxDays = 31
	elseif monthNr == 4 then maxDays = 30
	elseif monthNr == 5 then maxDays = 31
	elseif monthNr == 6 then maxDays = 30
	elseif monthNr == 7 then maxDays = 31
	elseif monthNr == 8 then maxDays = 31
	elseif monthNr == 9 then maxDays = 30
	elseif monthNr == 10 then maxDays = 31
	elseif monthNr == 11 then maxDays = 30
	elseif monthNr == 12 then maxDays = 31
	end
	return maxDays
end

local function GetMonthName(monthNr)
	local name = "none"
	if monthNr == 1 then name = "janvier"
	elseif monthNr == 2 then name = "février"
	elseif monthNr == 3 then name = "mars"
	elseif monthNr == 4 then name = "avril"
	elseif monthNr == 5 then name = "mai"
	elseif monthNr == 6 then name = "juin"
	elseif monthNr == 7 then name = "juillet"
	elseif monthNr == 8 then name = "aout"
	elseif monthNr == 9 then name = "septembre"
	elseif monthNr == 10 then name = "octobre"
	elseif monthNr == 11 then name = "novembre"
	elseif monthNr == 12 then name = "décembre"
	end
	return name
end

return {
	GetMonthMaxDays = GetMonthMaxDays,
	GetMonthName = GetMonthName,
}
