-- packer!
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use "rebelot/kanagawa.nvim"

	use { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' }

	-- setup telescope later
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or								, branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use { "stevearc/conform.nvim" }

	use { "tpope/vim-fugitive" }

	use { "airblade/vim-gitgutter" }

	use { "lervag/vimtex" }

	use { "andymass/vim-matchup" }

	use { "nmac427/guess-indent.nvim" }

	use { "kevinhwang91/promise-async" }
	use { "kevinhwang91/nvim-ufo" }

	use { "saghen/blink.cmp", tag = 'v1.*' }
end)
