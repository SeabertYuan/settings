-- packer!
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use "rebelot/kanagawa.nvim"

	use { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' }

	-- setup telescope later
	-- use {"ibhagwan/fzf-lua", { ["branch"] = "main" }}
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or								, branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	-- use {"nvim-tree/nvim-web-devicons"}

	use { "stevearc/conform.nvim" }

	use { "mfussenegger/nvim-lint" }

	use { "tpope/vim-fugitive" }

	use { "airblade/vim-gitgutter" }

	use { "lervag/vimtex" }
	-- use {"micangl/cmp-vimtex"}

	use { "andymass/vim-matchup" }

	use { "nmac427/guess-indent.nvim" }

	use { "kevinhwang91/promise-async" }
	use { "kevinhwang91/nvim-ufo" }
	-- use {"rust-lang/rust.vim"}

	use { "saghen/blink.cmp", tag = 'v1.*' }

	use({
		'MeanderingProgrammer/render-markdown.nvim',
		after = { 'nvim-treesitter' },
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
		-- config = function()
		-- 	require('render-markdown').setup({})
		-- end,
	})
end)
