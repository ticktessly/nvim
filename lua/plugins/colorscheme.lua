return {
	"folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		vim.cmd("colorscheme tokyonight")
	end,
}
--
-- return {
-- 	"bjarneo/vantablack.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("vantablack").setup()
-- 		vim.cmd.colorscheme("vantablack")
-- 	end,
-- }
