return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	keys = {
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
		{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Close buffer" },
	},
	opts = {
		options = {
			mode = "buffers",
			diagnostics = "nvim_lsp",
			show_buffer_close_icons = true,
			show_close_icon = false,
			separator_style = "slant",
			get_element_icon = function(el)
				return require("mini.icons").get("filetype", el.filetype)
			end,
		},
	},
}
