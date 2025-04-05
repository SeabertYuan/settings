require("nvim-treesitter.configs").setup({
	-- parsers to ignore installing
	ignore_install = { "latex" },
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"typescript",
		"javascript",
		"rust",
		"cpp",
		"bash",
		"html",
		"yuck",
		"css",
		"python",
		"nix",
		"swift",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		enable = true,
		disable = { "latex", "json" },
		additional_vim_regex_highlighting = false,
	},
})
