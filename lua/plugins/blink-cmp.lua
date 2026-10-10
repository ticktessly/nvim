---@brief blink.cmp (+ its friendly-snippets dependency)

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

vim.pack.add({
  gh("rafamadriz/friendly-snippets"), -- dependency, listed first
  -- was: version = "1.*" (lazy semver range)
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
}, no_load)

local load = make_loader({ "friendly-snippets", "blink.cmp" }, function()
  require("blink.cmp").setup({
    signature = { enabled = true },
    keymap = { preset = "super-tab" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    cmdline = {
      keymap = { preset = "super-tab" },
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
  })
end)

-- was: event = { "InsertEnter", "CmdlineEnter" }
for _, event in ipairs({ "InsertEnter", "CmdlineEnter" }) do
  vim.api.nvim_create_autocmd(event, {
    desc = "Lazy: blink.cmp",
    once = true,
    callback = load, -- shared loader, so it only ever loads once
  })
end