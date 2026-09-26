return {
	"ptdewey/yankbank-nvim",
	dependencies = { "kkharji/sqlite.lua" }, -- or "ptdewey/sqlite.lua" if that's the fork he used
	event = "VeryLazy",
	config = function()
		require("yankbank").setup({
			sep = "------",
			max_entries = 9,
			num_behavior = "jump",
			focus_gain_poll = true,
			keymaps = {},
			persist_type = "sqlite",
			debug = true,
			bind_indices = "<leader>y",
		})

		vim.keymap.set("n", "<leader>p", "<cmd>YankBank<CR>", { noremap = true, desc = "yankbank" })
	end,
}
