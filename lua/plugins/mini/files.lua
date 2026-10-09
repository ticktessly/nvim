return {
  "nvim-mini/mini.files",
  version = false,
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (current file)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
  opts = {
    mappings = {
      close = "q",
      go_in = "L",
      go_in_plus = "l",
      go_out = "H",
      go_out_plus = "h",
      reset = "<BS>",
      reveal_cwd = "@",
      synchronize = "=",
    },
    windows = {
      max_number = math.huge,
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
    options = {
      permanent_delete = true,
      use_as_default_explorer = true,
    },
  },
}
