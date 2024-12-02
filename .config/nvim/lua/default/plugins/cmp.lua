local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	sources = {
		{ name = "vimtex" },
		{ name = "nvim_lsp" },
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp_action.tab_complete(),
		["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
	}),
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine
require("lspconfig").clangd.setup({
	capabilities = capabilities,
})
