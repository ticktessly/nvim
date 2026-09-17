return {
	-- Treesitter parsers for Lua
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
		end,
	},

	-- Better Lua development for Neovim config/plugins
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "Lazy" } },
			},
		},
	},

	{ "Bilal2453/luvit-meta", lazy = true },

	-- LSP setup for Lua (lua_ls)

	{
		"neovim/nvim-lspconfig",
		opts = function()
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "Snacks" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")
		end,
	},

	-- Formatter for Lua
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.lua = { "stylua" }
		end,
	},

	-- Linter for Lua
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			opts.linters_by_ft = opts.linters_by_ft or {}
			opts.linters_by_ft.lua = { "luacheck" }
		end,
	},
}
