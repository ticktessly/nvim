local opts = vim.opt
opts.number = true
opts.relativenumber = true
opts.tabstop = 2
opts.shiftwidth = 2
opts.softtabstop = 2
opts.expandtab = true
opts.autoindent = true
opts.smartindent = true
opts.confirm = true
opts.clipboard = "unnamedplus"

vim.loader.enable()
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
