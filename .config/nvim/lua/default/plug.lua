local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("rebelot/kanagawa.nvim")

Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

Plug("ibhagwan/fzf-lua", { ["branch"] = "main" })

Plug("nvim-tree/nvim-web-devicons")

Plug("stevearc/conform.nvim")

Plug("mfussenegger/nvim-lint")

Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")

Plug("VonHeikemen/lsp-zero.nvim", { ["branch"] = "v3.x" })

Plug("tpope/vim-fugitive")

Plug("airblade/vim-gitgutter")

Plug("lervag/vimtex")
Plug("micangl/cmp-vimtex")

Plug("andymass/vim-matchup")

Plug("nmac427/guess-indent.nvim")

Plug("kevinhwang91/promise-async")
Plug("kevinhwang91/nvim-ufo")

-- Plug("rust-lang/rust.vim")

vim.call("plug#end")
