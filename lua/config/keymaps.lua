local map = vim.keymap.set
map("i", "jj", "<Esc>", { desc = "Exit insert mode", silent = true, noremap = true })
map("t", "``", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy", silent = true, noremap = true })
