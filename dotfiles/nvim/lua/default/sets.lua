vim.opt.showmode = false

vim.opt.nu = true
vim.opt.relativenumber = true


vim.opt.incsearch = true

vim.opt.scrolloff = 7

vim.opt.signcolumn = "yes"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true

-- useful for seeing if exceeding a maximum character per line length
vim.opt.colorcolumn = "80"

vim.opt.updatetime = 407

vim.opt.termguicolors = true

-- vim indents
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- netrw sorting
vim.g.netrw_sort_sequence = "[/]$,*,.bak$,.o$,.info$,.swp$,.obj$"

-- no more mouse
vim.opt.mouse = ""

-- split downwards
vim.opt.splitbelow = true
