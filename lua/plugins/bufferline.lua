---@brief bufferline.nvim

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

-- was: version = false (lazy: "never auto-update") -> pinned to lazy-lock.json.
vim.pack.add({
  { src = gh("akinsho/bufferline.nvim"), version = "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3" },
}, no_load)

local load = make_loader({ "bufferline.nvim" }, function()
  require("bufferline").setup({})
end)

-- was: event = { "BufAdd", "BufDelete" }
for _, event in ipairs({ "BufAdd", "BufDelete" }) do
  vim.api.nvim_create_autocmd(event, {
    desc = "Lazy: bufferline.nvim",
    once = true,
    callback = load, -- shared loader
  })
end

-- was: keys = { ... }. 2 mappings, so real wrappers, no stub/replay.
vim.keymap.set("n", "<S-h>", function()
  load()
  vim.cmd("BufferLineCyclePrev")
end, { desc = "Prev Buffer" })

vim.keymap.set("n", "<S-l>", function()
  load()
  vim.cmd("BufferLineCycleNext")
end, { desc = "Next Buffer" })