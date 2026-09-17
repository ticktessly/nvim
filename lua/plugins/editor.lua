return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      -- Simulate nvim-treesitter incremental selection
      { "<c-space>", mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            actions = {
              ["<c-space>"] = "next",
              ["<BS>"] = "prev"
            }
          }) 
        end, desc = "Treesitter Incremental Selection" },
    },
	},
	-- {
	-- 	"nvim-mini/mini.files",
	-- 	version = false,
	-- 	keys = {
	-- 		{
	-- 			"<leader>e",
	-- 			function()
	-- 				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
	-- 			end,
	-- 			desc = "Open mini.files (current file)",
	-- 		},
	-- 		{
	-- 			"<leader>E",
	-- 			function()
	-- 				require("mini.files").open(vim.uv.cwd(), true)
	-- 			end,
	-- 			desc = "Open mini.files (cwd)",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		windows = {
	-- 			preview = true,
	-- 			width_focus = 30,
	-- 			width_preview = 30,
	-- 		},
	-- 		options = {
	-- 			use_as_default_explorer = true,
	-- 		},
	-- 	},
	-- },
	{
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
	},
	{
		"martindur/zdiff.nvim",
		cmd = "Zdiff",
		keys = {
			{ "<leader>zd", "<cmd>Zdiff<cr>", desc = "Zdiff (uncommitted)" },
			{ "<leader>zD", "<cmd>Zdiff main<cr>", desc = "Zdiff (vs main)" },
		},
		opts = {},
	},
	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		version = false,
		opts = {},
	},
}
