return {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		dashboard = { enabled = true },
		scroll = { enabled = false },
		explorer = { enabled = true },
		indent = { enabled = true },
		lazygit = { enabled = true },
	},
	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "LazyGit",
		},
	},
}
