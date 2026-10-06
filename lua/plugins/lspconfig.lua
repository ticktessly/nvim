return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "saghen/blink.cmp" },
	config = function()
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		vim.lsp.enable("emmylua_ls")
		vim.lsp.enable("gopls")
		vim.lsp.enable("ty")
		vim.lsp.enable("vtsls")
		vim.lsp.enable("sqls")
	end,
}
