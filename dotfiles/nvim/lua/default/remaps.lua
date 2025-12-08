-- move line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move line below to current line
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- competitive programming
local function set_cp_keymaps(buf)
    local ft = vim.bo[buf].filetype

    if ft == "cpp" or ft == "c" then
        -- C/C++ compile
        vim.keymap.set("n", "<leader>rm",
            "<cmd>!g++ -g --std=c++11 -O2 -Wall % -o %:r<CR>",
            { buffer = buf, desc = "Compile C++" }
        )
    elseif ft == "rust" then
        -- Rust compile
        vim.keymap.set("n", "<leader>rm",
            "<cmd>!rustc % -o %:r<CR>",
            { buffer = buf, desc = "Compile Rust" }
        )
    end

    -- Run (same for rust/cpp)
    vim.keymap.set("n", "<leader>rr",
        ":term ./%:r<CR>",
        { buffer = buf, desc = "Run binary" }
    )

    -- Run all *.test input files
    vim.keymap.set("n", "<leader>rt",
        "<cmd>!for f in %:r.*.test; do echo 'TEST: $f'; ./%:r < $f; done<CR>",
        { buffer = buf, desc = "Run tests" }
    )
end

-- Autocmd: activate only for C/C++/Rust files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "c", "rust" },
    callback = function(args)
        set_cp_keymaps(args.buf)
    end,
})
