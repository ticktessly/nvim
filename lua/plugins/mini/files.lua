return {
	"nvim-mini/mini.files",
	version = false,
	keys = {
		{
			"<leader>e",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end,
			desc = "Open mini.files (current file)",
		},
		{
			"<leader>E",
			function()
				require("mini.files").open(vim.uv.cwd(), true)
			end,
			desc = "Open mini.files (cwd)",
		},
	},
	opts = {
		windows = {
			preview = true,
			width_focus = 30,
			width_preview = 30,
		},
		options = {
			use_as_default_explorer = true,
		},
	},
}
