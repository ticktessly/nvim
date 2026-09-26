return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	opts = {
		keymap = { preset = "super-tab" },
		sources = {
			-- Add lazydev to the default list of sources
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (score_offset >= 0)
					score_offset = 100,
				},
			},
		},
		completion = {
			menu = {
				border = "rounded",
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
				},
			},
		},
		cmdline = {
			keymap = { preset = "super-tab" },
			completion = {
				menu = {
					auto_show = true,
					border = "rounded",
				},
			},
		},
	},
}
