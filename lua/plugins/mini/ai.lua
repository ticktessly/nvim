---@brief mini.ai

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

-- was: version = false (lazy: "never auto-update") -> pinned to lazy-lock.json.
vim.pack.add({
  { src = gh("nvim-mini/mini.ai"), version = "c2c4278beb759aa24b9506f56a67186a6cc2209c" },
}, no_load)

local load = make_loader({ "mini.ai" }, function()
  require("mini.ai").setup({})
end)

-- was: event = "VeryLazy"
vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Lazy: mini.ai",
  once = true,
  callback = function()
    vim.schedule(load)
  end,
})