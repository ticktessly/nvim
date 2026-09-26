return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		defaults = {
			path_display = { "smart" },
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		pcall(telescope.load_extension, "projects")
	end,
	keys = {
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep Files",
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Recent",
		},
		{
			"<leader><space>",
			function()
				local builtin = require("telescope.builtin")
				local ok = pcall(builtin.git_files, { show_untracked = true, recurse_submodules = true })
				if not ok then
					builtin.find_files({ hidden = true, no_ignore = true })
				end
			end,
			desc = "Smart Find Files",
		},
	},
}
