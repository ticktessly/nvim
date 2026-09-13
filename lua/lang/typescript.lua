return {
	-- Treesitter parsers for TypeScript / JavaScript
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx", "jsdoc" })
		end,
	},

	-- LSP setup for TypeScript
	{
		"neovim/nvim-lspconfig",
		opts = function()
			vim.lsp.enable("vtsls")
		end,
	},

	-- Formatter for TypeScript / JavaScript
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.javascript = { "prettierd", "prettier", stop_after_first = true }
			opts.formatters_by_ft.typescript = { "prettierd", "prettier", stop_after_first = true }
			opts.formatters_by_ft.javascriptreact = { "prettierd", "prettier", stop_after_first = true }
			opts.formatters_by_ft.typescriptreact = { "prettierd", "prettier", stop_after_first = true }
		end,
	},

	-- Linter for TypeScript / JavaScript
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			opts.linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft.javascript = { "eslint" }
			opts.linters_by_ft.typescript = { "eslint" }
		end,
	},
}
