local map = vim.keymap.set
map("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })
-- was: <cmd>Lazy<cr>. `:Lazy sync` is now `:lua vim.pack.update()`, which opens a
-- confirmation buffer (`:write` to apply, `:quit` to discard). See MIGRATION.md.
map("n", "<leader>l", "<cmd>lua vim.pack.update()<cr>", { desc = "Update plugins", silent = true, noremap = true })
