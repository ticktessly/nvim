---@brief
---
--- Disable bundled `$VIMRUNTIME/plugin/*` files.
---
--- This replaces lazy.nvim's `performance.rtp.disabled_plugins`. There is no
--- `vim.pack` equivalent -- lazy used to do it by taking over plugin loading
--- entirely (`vim.go.loadplugins = false` in `lazy/core/config.lua`), which we
--- no longer do. Instead each runtime file is skipped via the guard variable it
--- checks for itself, set here before Nvim sources `plugin/`.
---
--- Verified against the guards in each file (Neovim 0.12.5):
---   netrwPlugin.vim:3   g:loaded_netrwPlugin
---   tutor.vim:7         g:loaded_tutor_mode_plugin
---   tarPlugin.vim:15    g:loaded_tarPlugin
---   zipPlugin.vim:24    g:loaded_zipPlugin
---   gzip.vim:10         g:loaded_gzip
---   rplugin.vim:1       g:loaded_remote_plugins
---   spellfile.lua:1     g:loaded_spellfile_plugin
---   man.lua:1           g:loaded_man
---
--- ("dir" was also in the old list but `dir.vim` no longer exists in Neovim.)

vim.g.loaded_netrwPlugin = true -- replaced by mini.files
vim.g.loaded_tutor_mode_plugin = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_gzip = true
vim.g.loaded_remote_plugins = true
vim.g.loaded_spellfile_plugin = true
vim.g.loaded_man = true