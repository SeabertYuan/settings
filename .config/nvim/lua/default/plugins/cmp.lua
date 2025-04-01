-- local cmp = require("cmp")
-- local cmp_action = require("lsp-zero").cmp_action()
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..

-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			require('luasnip').lsp_expand(args.body)
-- 		end,
-- 	},
-- 	mapping = {
-- 		["<CR>"] = cmp.mapping.confirm({ select = false }),
-- 		["<Tab>"] = cmp.mapping(function(fallback)
-- 		  -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
-- 		  if cmp.visible() then
-- 			local entry = cmp.get_selected_entry()
-- 			if not entry then
-- 			  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
-- 			end
-- 			cmp.confirm()
-- 		  else
-- 			fallback()
-- 		  end
-- 		end, {"i","s","c",}),
-- 		-- ["<Tab>"] = cmp_action.tab_complete(),
-- 		-- ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
-- 	},
-- 	sources = cmp.config.sources({
-- 		-- { name = "nvim_lsp" },
-- 		{ name = "luasnip" },
-- 		{ name = "vimtex" },
-- 	}, {
-- 		{ name = 'buffer' },
-- 	})
-- })


-- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine
-- require("lspconfig").clangd.setup({
-- 	capabilities = capabilities,
-- })

require('blink.cmp').setup({
    keymap = { preset = 'default' },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

capabilities = vim.tbl_deep_extend('force', capabilities, {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
})
