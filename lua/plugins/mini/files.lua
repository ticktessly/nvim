---@brief mini.files
---
--- lazy.nvim only had `keys` here (no `event`), so it was implicitly lazy and
--- lazy's default of playing the keypress back is not needed: 2 mappings get
--- real wrappers that load first and then call the function.

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

-- was: version = false (lazy: "never auto-update") -> pinned to lazy-lock.json.
vim.pack.add({
  { src = gh("nvim-mini/mini.files"), version = "7821bb920b8f0b114c756fb9bd39fd62d76961ac" },
}, no_load)

local load = make_loader({ "mini.files" }, function()
  require("mini.files").setup({
    mappings = {
      close = "q",
      go_in = "L",
      go_in_plus = "l",
      go_out = "H",
      go_out_plus = "h",
      reset = "<BS>",
      reveal_cwd = "@",
      synchronize = "=",
    },
    windows = {
      max_number = math.huge,
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
    options = {
      permanent_delete = true,
      use_as_default_explorer = true,
    },
  })
end)

-- was: keys = { ... } (real mapping, no stub/replay)
vim.keymap.set("n", "<leader>e", function()
  load()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Open mini.files (current file)" })

vim.keymap.set("n", "<leader>E", function()
  load()
  require("mini.files").open(vim.uv.cwd(), true)
end, { desc = "Open mini.files (cwd)" })