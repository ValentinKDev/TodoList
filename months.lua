function Truc1()
	_VIM.cmd([[ hi UnRealisedBranch guifg=#802510]])
	_VIM.cmd([[ match UnRealisedBranch /\s*\p✕.*\Z/ ]])
end
function Truc2()
	_VIM.highlight.create('RealisedBranch', {
		guifg = 'none',
		guibg = 'blue',
	})
--	_VIM.cmd([[ hi RealisedBranch guifg=#258050]])	
	_VIM.cmd([[ match RealisedBranch /\s*\p✔.*\Z/ ]])
end
--Truc1()
print("init months.lua")

