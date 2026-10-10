local map = vim.keymap.set
map("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Open Lazy", silent = true, noremap = true })
