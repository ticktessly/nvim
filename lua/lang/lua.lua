return {
	-- Mason tooling for Lua
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "emmylua_ls" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "stylua", "luacheck" })
		end,
	},

	-- Treesitter parsers for Lua
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
		end,
	},

	-- Neovim API completion & type definitions for Lua
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- LSP setup for Lua (emmylua_ls)
	{
		"neovim/nvim-lspconfig",
		opts = function()
			vim.lsp.config("emmylua_ls", {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							and (vim.uv.fs_stat(path .. "/.emmyrc.json") or vim.uv.fs_stat(path .. "/.luarc.json"))
						then
							client.config.settings = {}
						end
					end
				end,
				settings = {
					emmylua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
								vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
							},
						},
					},
				},
			})
			vim.lsp.enable("emmylua_ls")
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
