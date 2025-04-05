-- luacheck: globals vim
-- local lsp_zero = require("lsp-zero")
--
-- lsp_zero.on_attach(function(client, bufnr)
-- 	lsp_zero.default_keymaps({ buffer = bufnr })
-- end)
--
-- require("mason").setup({})
-- require("mason-lspconfig").setup({
-- 	ensure_installed = {},
-- 	handlers = {
-- 		function(server_name)
-- 			require("lspconfig")[server_name].setup({})
-- 		end,
-- 	},
-- })
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	virtual_text = false,
-- 	underline = true,
-- 	signs = true,
-- 	update_in_insert = false,
-- 	severity_sort = false,
-- })

-- idk what this does I don't think I need it tbh
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('*', {
  root_markers = { '.git' },
  -- capabilities = {
  --  capabilities,
  -- },
})

-- vim.lsp.config['luals'] = {
--   cmd = { 'lua-language-server' },
--   filetypes = { 'lua' },
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         globals = { 'vim' },
--       },
--     }
--   }
-- }

-- vim.lsp.enable('luals');

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "typescript", "javascript" },
  callback = function()
    if vim.fn.executable('biome') == 1 then
      local biome_client_id = vim.lsp.start({
        name = 'biome',
        cmd = { 'biome', 'lsp-proxy' },
        root_dir = vim.fs.dirname(vim.fs.find({ "package.json" }, { upward = true })[1]),
      })
      if biome_client_id then
        vim.lsp.buf_attach_client(0, biome_client_id)
      end
    end
    if vim.fn.executable('typescript-language-server') == 1 then
      local tls_client_id = vim.lsp.start({
        name = 'typescript-language-server',
        cmd = { 'typescript-language-server', '--stdio' },
        root_dir = vim.fs.dirname(vim.fs.find({ "package.json" }, { upward = true })[1]),
        -- on_attach = function(client, bufnr)
        --   vim.lsp.completion.enable(true, client.id, bufnr, {
        --     autotrigger = true,
        --     convert = function(item)
        --       return { abbr = item.label:gsub('%b()', '') }
        --     end,
        --   })
        -- end,
      })
      if tls_client_id then
        vim.lsp.buf_attach_client(0, tls_client_id)
      end
    end
  end
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "rust", },
  callback = function()
    local rust_analyzer_client_id = vim.lsp.start({
      name = 'rust-analyzer',
      cmd = { 'rust-analyzer' },
      root_dir = vim.fs.dirname(vim.fs.find({ "Cargo.lock", "Cargo.toml" }, { upward = true })[1]),
    })
    if rust_analyzer_client_id then
      vim.lsp.buf_attach_client(0, rust_analyzer_client_id)
    end
  end
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "java", },
  callback = function()
    local jdtls_client_id = vim.lsp.start({
      name = 'jdtls',
      cmd = { 'jdtls' },
      root_dir = vim.fs.dirname(vim.fs.find({ "pom.xml", "settings.gradle" }, { upward = true })[1]),
    })
    if jdtls_client_id then
      vim.lsp.buf_attach_client(0, jdtls_client_id)
    end
  end
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "lua", },
  callback = function()
    local luals_client_id = vim.lsp.start({
      name = 'luals',
      cmd = { 'lua-language-server' },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' },
          },
        }
      },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
          end,
        })
      end
    })
    if luals_client_id then
      vim.lsp.buf_attach_client(0, luals_client_id)
    end
  end
})

-- lsp error popups
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
