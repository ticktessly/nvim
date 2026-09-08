return {
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
			completion = { documentation = { auto_show = true } },
			cmdline = {
				keymap = { preset = "super-tab" },
				completion = { menu = { auto_show = true } },
			},
		},
	},
}
