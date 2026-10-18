return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      layout = {
        preset = "default",
        preview = "main",
        cycle = true,
      },
      sources = {
        explorer = {
          hidden = true,
          ignored = false,
          follow_current_file = { enabled = true, leave_dirs_open = true },
          layout = {
            preset = "right",
            layout = { width = 40 },
          },
        },
        git = {
          ignore_pattern = "%.sync",
        },
      },
    },
    explorer = {
      enabled = true,
    },
    indent = {
      enabled = true,
      options = {
        show_current_context = true,
        show_scope_lines = true,
        show_virtual_text = true,
      },
    },
    scope = {
      enabled = true,
      text_object = {
        inner = true,
        ["if-unix"] = true,
      },
    },
  },
  keys = {
    -- Explorer
    {
      "<leader>e",
      function() Snacks.explorer() end,
      desc = "Explorer (current file)",
    },
    -- Picker
    { "<leader>ff", function() require("snacks.picker").files() end, desc = "Find Files" },
    { "<leader>fg", function() require("snacks.picker").grep() end, desc = "Live Grep" },
    { "<leader>fb", function() require("snacks.picker").buffers() end, desc = "Buffers" },
    { "<leader>fr", function() require("snacks.picker").recent() end, desc = "Recent Files" },
  },
}
