return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.lsp.config("emmylua_ls", {
				on_init = function(client)
					-- If the workspace has its own emmylua_ls/lua_ls config file, defer to it.
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
						-- Tell the server which Lua you're using (usually LuaJIT, for Neovim).
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						-- Make the server aware of Neovim runtime files.
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
								-- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
								vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
							},
							-- Or pull in all of 'runtimepath'. May be slower!
							-- library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			})

			vim.lsp.enable("emmylua_ls")
			vim.lsp.enable("gopls")
			vim.lsp.enable("ty")
			vim.lsp.enable("vtsls")

			-- LspAttach keybindings
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						vim.tbl_extend("force", opts, { desc = "LSP: Go to definition" })
					)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover" }))
					vim.keymap.set(
						"n",
						"<leader>rn",
						vim.lsp.buf.rename,
						vim.tbl_extend("force", opts, { desc = "LSP: Rename symbol" })
					)
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						vim.tbl_extend("force", opts, { desc = "LSP: Code action" })
					)
				end,
			})
		end,
	},
}
