-- Tex settings
vim.api.nvim_create_autocmd({ "Filetype" }, {
	pattern = "tex",
	callback = function()
		vim.opt_local.colorcolumn = ""
		-- very important for speed
		vim.opt_local.cursorcolumn = false
		vim.opt_local.cursorline = false
	end,
})

-- annoying comments (not sure why it matters what filetype)
vim.api.nvim_create_autocmd({ "Filetype" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})
