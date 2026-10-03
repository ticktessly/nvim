return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integrations = {
				barbecue = {
					alt_background = false,
					bold_basename = true,
					dim_context = false,
					dim_dirname = true,
				},
				blink_cmp = {
					enabled = true,
					style = "bordered",
				},
				colorful_winsep = {
					color = "red",
				},
				dropbar = {
					color_mode = false,
				},
				flash = true,
				illuminate = {
					lsp = false,
				},
				indent_blankline = {
					colored_indent_levels = false,
					scope_color = "",
				},
				lir = {
					git_status = false,
				},
				mini = {
					enabled = true,
					indentscope_color = "overlay2",
				},
				navic = {
					custom_bg = "NONE",
				},
				telescope = true,
			},
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
