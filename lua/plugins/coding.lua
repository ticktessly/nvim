return {
	{
		"nvim-mini/mini.pairs",
		event = "InsertEnter",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			keymap = { preset = "super-tab" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			cmdline = {
				keymap = { preset = "super-tab" },
				completion = { menu = { auto_show = true } },
			},
		},
	},
	{
		"nvim-mini/mini.surround",
		event = "VeryLazy",
		version = false,
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		version = false,
		opts = {},
	},
	{
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
	},
}
