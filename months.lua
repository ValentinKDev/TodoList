function Truc1()
	vim.cmd([[ hi UnRealisedBranch guifg=#802510]])
	vim.cmd([[ match UnRealisedBranch /\s*\p✕.*\Z/ ]])
end
function Truc2()
	vim.highlight.create('RealisedBranch', {
		guifg = 'none',
		guibg = 'blue',
	})
--	vim.cmd([[ hi RealisedBranch guifg=#258050]])	
	vim.cmd([[ match RealisedBranch /\s*\p✔.*\Z/ ]])
end
Truc1()

