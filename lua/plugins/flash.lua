---@brief flash.nvim
---
--- `s` is a *motion*, mapped in normal/visual/operator-pending. Replaying the
--- keypress would lose operator-pending state (`d s foo` would break), so this
--- uses a real wrapper instead. That is also exactly what flash.nvim's own
--- README recommends:
---   `vim.keymap.set({'n','x','o'}, 's', function() require('flash').jump() end)`

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

vim.pack.add({ gh("folke/flash.nvim") }, no_load)

local load = make_loader({ "flash.nvim" }, function()
  require("flash").setup({})
end)

-- was: event = "VeryLazy"
vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Lazy: flash.nvim",
  once = true,
  callback = function()
    vim.schedule(load)
  end,
})

-- was: keys = { { "s", ..., mode = { "n", "x", "o" } } }
vim.keymap.set({ "n", "x", "o" }, "s", function()
  load()
  require("flash").jump()
end, { desc = "Flash" })