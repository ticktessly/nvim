return {
	{
		"folke/noice.nvim",
		depencencies = { "MunifTanjim/nui.nvim" },
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
	   -- stylua: ignore
	   config = function(_, opts)
	     -- HACK: noice shows messages from before it was enabled,
	     -- but this is not ideal when Lazy is installing plugins,
	     -- so clear the messages in this case.
	     if vim.o.filetype == "lazy" then
	       vim.cmd([[messages clear]])
	     end
	     require("noice").setup(opts)
	   end,
	},
	{
		"nvim-mini/mini.icons",
		event = "VeryLazy",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
	},
}
