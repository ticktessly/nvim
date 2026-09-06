return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			keymap = { preset = "super-tab" },
			sources = {
				default = { "lazydev", "lsp", "path", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- prioritize lazydev over heavy lua_ls results
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
