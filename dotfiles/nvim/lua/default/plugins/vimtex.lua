-- luacheck: globals vim
-- vim.opt.conceallevel = 2

vim.g.vimtex_view_method = "zathura_simple"

vim.g.vimtex_compiler_method = 'tectonic'
vim.g.vimtex_quickfix_method = 'pplatex'

-- could be useful to speed up latex
-- vim.g.vimtex_matchparen_enabled = 0

-- vim.g.vimtex_matchparen_timeout = 10
-- vim.g.vimtex_matchparen_insert_timeout = 10

-- vim.g.vimtex_delim_stopline = 300

vim.g.vimtex_quickfix_mode = 0

-- use vim-matchup to improve vimtex
vim.g.matchup_override_vimtex = 1

vim.g.matchup_matchparen_deferred = 1

-- formatting
vim.g.vimtex_format_enabled = 1

-- folding
vim.g.vimtex_fold_enabled = 1
