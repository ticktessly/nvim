---@brief telescope.nvim (+ plenary and telescope-fzf-native dependencies)
---
--- The fzf-native build hook lives in `plugins/build.lua`.

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

vim.pack.add({
  gh("nvim-lua/plenary.nvim"), -- dependency, listed first
  gh("nvim-telescope/telescope-fzf-native.nvim"), -- dependency, `make`d by build.lua
  gh("nvim-telescope/telescope.nvim"),
}, no_load)

local load = make_loader({ "plenary.nvim", "telescope-fzf-native.nvim", "telescope.nvim" }, function()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
    },
    extensions = {
      fzf = {},
    },
  })
  telescope.load_extension("fzf")
end)

-- was: cmd = "Telescope"
-- Limitation: until it is loaded, `:Telescope` does not exist, so command-line
-- completion will not offer it.
vim.api.nvim_create_autocmd("CmdUndefined", {
  desc = "Lazy: telescope.nvim",
  pattern = "Telescope",
  once = true,
  callback = load,
})

-- was: keys = { ... }. 3 mappings, so real wrappers instead of lazy's
-- stub + `nvim_feedkeys(..., 'm')` replay.
vim.keymap.set("n", "<leader>ff", function()
  load()
  vim.cmd("Telescope find_files")
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fg", function()
  load()
  vim.cmd("Telescope live_grep")
end, { desc = "Live Grep" })

vim.keymap.set("n", "<leader>fb", function()
  load()
  vim.cmd("Telescope buffers")
end, { desc = "Buffers" })