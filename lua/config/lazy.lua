-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Add support for the LazyFile event (like LazyVim does)
-- "LazyFile" is an alias for BufReadPost/BufWritePost/BufNewFile, but it is
-- deferred: lazy.nvim only loads LazyFile plugins when one of these fires,
-- then re-triggers the event so autocmds created by the loaded plugins still
-- run for the buffer that triggered it. This keeps the initial UI render fast.
local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = {
  id = "LazyFile",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.mini" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "tutor",
        "tarPlugin",
        "gzip",
        "zipPlugin",
        "spellfile",
        "rplugin",
        "man",
        "dir",
        "netrwPlugin", -- replaced by snacks.explorer
      },
    },
  },
})
