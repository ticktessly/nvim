---@brief mini.statusline
---
--- version = false under lazy.nvim meant "never auto-update". `vim.pack` has no
--- such flag; the documented freeze (`:h vim.pack`, "Freeze plugin from being
--- updated") is `version` set to the current revision. Pinned to the commit
--- from lazy-lock.json -- see MIGRATION.md before unpinning.

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

-- was: version = false
vim.pack.add({
  { src = gh("nvim-mini/mini.statusline"), version = "127997ebef7ef632161203b960c5ef9d158f4810" },
}, no_load)

-- mini.icons is already loaded eagerly, so it needs no packadd here.
local load = make_loader({ "mini.statusline" }, function()
  require("mini.statusline").setup({})
end)

-- was: event = "VeryLazy"
vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Lazy: mini.statusline",
  once = true,
  callback = function()
    vim.schedule(load)
  end,
})