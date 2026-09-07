return {
	-- Mason tooling for Python
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "pyright" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "ruff" })
		end,
	},

	-- Treesitter parser for Python
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "python" })
		end,
	},

	-- LSP setup for Python
	{
		"neovim/nvim-lspconfig",
		opts = function()
			vim.lsp.enable("pyright")
		end,
	},

	-- Formatter for Python
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.python = { "ruff_format", "isort" }
		end,
	},

	-- Linter for Python
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			opts.linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft.python = { "ruff" }
		end,
	},
}
