---@brief nvim-treesitter
---
--- The `:TSUpdate` build hook lives in `plugins/build.lua`.

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

-- was: branch = "main"
vim.pack.add({
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
}, no_load)

local load = make_loader({ "nvim-treesitter" }, function()
  require("nvim-treesitter").setup({
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "go",
      "gomod",
      "gowork",
      "gotmpl",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    indent = { enabled = true },
    highlighting = { enabled = true },
  })
end)

-- was: event = { "BufReadPost", "BufNewFile" }
-- `setup()` installs/attaches parsers for the current buffer, so the trigger
-- events and the setup happen together (unlike a pure `ft` trigger, where a
-- filetype plugin would need re-triggering).
for _, event in ipairs({ "BufReadPost", "BufNewFile" }) do
  vim.api.nvim_create_autocmd(event, {
    desc = "Lazy: nvim-treesitter",
    once = true,
    callback = load, -- shared loader
  })
end

-- was: cmd = { "TSUpdate", "TSInstall" }
-- Limitation: until loaded, these commands do not exist for completion.
for _, cmd in ipairs({ "TSUpdate", "TSInstall" }) do
  vim.api.nvim_create_autocmd("CmdUndefined", {
    desc = "Lazy: nvim-treesitter",
    pattern = cmd,
    once = true,
    callback = load, -- shared loader
  })
end