vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
})

vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], { noremap = true })
