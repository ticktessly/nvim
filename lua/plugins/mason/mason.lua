return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			run_on_start = true,
			ensure_installed = {
				"emmylua_ls",
				"gopls",
				"ty",
				"vtsls",
				"sqls",

				"gofumpt",
				"goimports",
				"prettierd",
				"prettier",
				"stylua",
				"ruff",
				"shfmt",
				"sqlfluff",

				"golangci-lint",
				"eslint_d",
				"luacheck",
			},
			start_delay = 0,
			debounce_hours = 24,
			notify = false,
		},
	},
}
