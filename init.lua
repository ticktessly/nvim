-- `vim.pack` installs plugins into `stdpath('data')/site/pack/core/opt`, and
-- `:h vim.pack` notes that `site` "needs to be part of 'packpath'. It usually
-- is, but might not be". This Termux build ships a minimal 'packpath' (the
-- runtime dir only), so without this every `:packadd` would fail to find the
-- plugins `vim.pack` just installed.
vim.opt.packpath:append(vim.fn.stdpath("data") .. "/site")

-- Must be set before any keymap or plugin code so mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.rtp")
require("config.keymaps")
require("config.opts")
require("config.autocmd")

-- Build hooks must be registered before the plugins they build (see :h vim.pack).
require("plugins.build")

-- Plugins, in dependency order.
require("plugins.mini.icons") -- eager; provides the nvim-web-devicons shim
require("plugins.mini.statusline")
require("plugins.mini.pairs")
require("plugins.mini.ai")
require("plugins.mini.files")
require("plugins.blink-cmp")
require("plugins.telescope")
require("plugins.nvim-treesitter")
require("plugins.conform")
require("plugins.nvim-lint")
require("plugins.bufferline")
require("plugins.flash")
require("plugins.noice")
require("plugins.smear-cursor")

vim.lsp.enable("gopls")
vim.lsp.enable("emmylua_ls")