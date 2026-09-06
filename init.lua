-- Make sure to setup `mapleader` and `maplocalleader` before loading
-- lazy.nvim so that mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
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

-- Setup lazy.nvim and import specs from `./lua/plugins/`
require("lazy").setup({
	spec = {
		{ import = "plugins" },
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
				"netrwPlugin", -- replaced by mini.files
			},
		},
	},
})

-- KEYMAPS
local map = vim.keymap.set
map("i", "jj", "<Esc>", { silent = true, noremap = true })
map("t", "``", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { silent = true, noremap = true })

-- CONFIG
local opt = vim.o
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.confirm = true

vim.diagnostic.enable = true
