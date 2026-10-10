---@brief smear-cursor.nvim

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

vim.pack.add({ gh("sphamba/smear-cursor.nvim") }, no_load)

local load = make_loader({ "smear-cursor.nvim" }, function()
  -- NOTE: the module is `smear_cursor`, not `smear`. lazy.nvim derived this
  -- automatically from the plugin name (dashes -> underscores, drop ".nvim").
  require("smear_cursor").setup({})
end)

-- was: event = "VeryLazy"
vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Lazy: smear-cursor.nvim",
  once = true,
  callback = function()
    vim.schedule(load)
  end,
})