_G.lsp_enabled = false

vim.api.nvim_create_user_command("LspEnable", function()
  _G.lsp_enabled = true
  vim.api.nvim_exec_autocmds('FileType', {})
end, {
  desc = "Enable LSP",
})
vim.api.nvim_create_user_command("LspDisable", function()
  _G.lsp_enabled = false
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      for _, client in ipairs(clients) do
        vim.lsp.buf_detach_client(bufnr, client.id)
      end
    end
  end
end, {
  desc = "Disable LSP",
})

vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "typescript", "javascript" },
  callback = function()
    if not _G.lsp_enabled then
      return
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
    if not _G.lsp_enabled then
      return
    end
    if vim.fn.executable('rust-analyzer') == 1 then
      local rust_analyzer_client_id = vim.lsp.start({
        name = 'rust-analyzer',
        cmd = { 'rust-analyzer' },
        root_dir = vim.fs.dirname(vim.fs.find({ "Cargo.lock", "Cargo.toml" }, { upward = true })[1]),
      })
      if rust_analyzer_client_id then
        vim.lsp.buf_attach_client(0, rust_analyzer_client_id)
      end
    end
  end
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "java", },
  callback = function()
    if not _G.lsp_enabled then
      return
    end
    if vim.fn.executable('jdtls') == 1 then
      local jdtls_client_id = vim.lsp.start({
        name = 'jdtls',
        cmd = { 'jdtls' },
        root_dir = vim.fs.dirname(vim.fs.find({ "pom.xml", "settings.gradle" }, { upward = true })[1]),
      })
      if jdtls_client_id then
        vim.lsp.buf_attach_client(0, jdtls_client_id)
      end
    end
  end
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "lua", },
  callback = function()
    if not _G.lsp_enabled then
      return
    end
    if vim.fn.executable('luals') == 1 then
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
  end
})

-- lsp error popups
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
