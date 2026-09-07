return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
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
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- prioritize lazydev over heavy emmylua_ls results
					},
				},
			},
			completion = { documentation = { auto_show = true } },
			cmdline = {
				keymap = { preset = "super-tab" },
				completion = { menu = { auto_show = true } },
			},
		},
	},
}
