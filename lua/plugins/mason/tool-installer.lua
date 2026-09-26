--- Installs every external binary referenced by lspconfig, conform.nvim and
--- nvim-lint so a fresh machine only needs `:MasonUpdate` to be code-ready.
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("mason-tool-installer").setup({
			run_on_start = true,
			ensure_installed = {
				"lua-language-server",
				"gopls",
				"ty",
				"vtsls",

				"gofumpt",
				"goimports",
				"prettierd",
				"prettier",
				"stylua",
				"ruff",
				"isort",
				"shfmt",

				"golangci-lint",
				"eslint_d",
				"luacheck",
			},
			start_delay = 0,
			debounce_hours = 24,
			notify = false,
		})
	end,
}
