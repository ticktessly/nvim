---@brief mini.pairs

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

vim.pack.add({ gh("nvim-mini/mini.pairs") }, no_load)

-- mini.icons is loaded eagerly, so it needs no packadd here.
local load = make_loader({ "mini.pairs" }, function()
  require("mini.pairs").setup({
    modes = { insert = true, command = true, terminal = false },
    -- skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    -- skip autopair when the cursor is inside these treesitter nodes
    skip_ts = { "string" },
    -- skip autopair when next character is closing pair
    -- and there are more closing pairs than opening pairs
    skip_unbalanced = true,
    -- better deal with markdown code blocks
    markdown = true,
  })
end)

-- was: event = "InsertEnter"
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Lazy: mini.pairs",
  once = true,
  callback = load,
})