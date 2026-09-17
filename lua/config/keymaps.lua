local map = vim.keymap.set
map("i", "jj", "<Esc>", { desc = "Exit insert mode", silent = true, noremap = true })
map("t", "``", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy", silent = true, noremap = true })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
