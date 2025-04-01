-- Used for fuzzy-finding files quickly in lua

-- for fzf.lua
-- vim.keymap.set("n", "<c-P>",
--   "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })

-- for telescope.nvim
vim.keymap.set("n", "<c-P>",
    require('telescope.builtin').find_files, { desc = 'Telescope find files' })

require('telescope').setup{
    defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
            prompt_position = 'top'
        },
    },
}
