return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = {
		linters_by_ft = {
			go = { "golangcilint" },
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			lua = { "luacheck" },
			python = { "ruff" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			vue = { "eslint_d" },
		},
	},
	config = function(_, opts)
		local lint = require("lint")
		lint.linters_by_ft = opts.linters_by_ft or {}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
