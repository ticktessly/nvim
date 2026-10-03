return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			auto_integrations = false, -- skip the expensive detection
			integrations = {
				blink_cmp = true,
				flash = true,
				mason = true,
				mini = { enabled = true },
				noice = true,
				telescope = { enabled = true },
				treesitter = true,
				native_lsp = { enabled = true },
			},
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
