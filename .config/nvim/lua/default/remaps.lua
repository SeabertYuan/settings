-- move line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move line below to current line
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- competitive programming
-- compile
vim.keymap.set("n", "<leader>rm", "<cmd>!g++ -g --std=c++11 -O2 -Wall % -o %:r<CR>")
-- run on simple inputs?
vim.keymap.set("n", "<leader>rr", ":term ./%:r<CR>")
-- run on a test file
vim.keymap.set("n", "<leader>rt", "<cmd>!for f in %:r.*.test; do echo 'TEST: $f'; ./%:r < $f; done<CR>")
