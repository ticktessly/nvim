local opts = vim.o
opts.number = true
opts.relativenumber = true
opts.tabstop = 2
opts.shiftwidth = 2
opts.softtabstop = 2
opts.expandtab = true
opts.confirm = true
opts.clipboard = "unnamedplus"

vim.diagnostic.enable = true
vim.loader.enable()
