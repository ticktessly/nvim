return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdate", "TSInstall" },
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"printf",
			"python",
			"query",
			"regex",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)

		-- install any missing parsers (async)
		require("nvim-treesitter").install(opts.ensure_installed)

		-- highlighting: enabled per-buffer via autocmd (no more `highlight.enable`)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = opts.ensure_installed, -- limit to filetypes matching parser names; adjust if ft != parser name
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})

		-- indent: use treesitter's indentexpr
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local ok = pcall(vim.treesitter.get_parser, 0)
				if ok then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
