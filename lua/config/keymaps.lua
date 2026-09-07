local map = vim.keymap.set
map("i", "jj", "<Esc>", { silent = true, noremap = true })
map("t", "``", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { silent = true, noremap = true })
