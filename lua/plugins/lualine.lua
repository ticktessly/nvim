return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  version = false,
  dependencies = "nvim-mini/mini.icons",
  opts = {
    options = {
      -- "auto" makes lualine pick up the active colorscheme's highlights.
      theme = "auto",
      icons_enabled = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "filename" },
      lualine_c = {
        {
          "diagnostics",
          symbols = { error = "  ", warn = "  ", info = " ", hint = " 󰌵 " },
        },
      },
      lualine_x = {
        "encoding",
        "filetype",
        { "progress", symbols = { smooth = " " } },
        {
          "lsp_status",
          spinner = { frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" } },
        },
      },
      lualine_y = { "location" },
      lualine_z = {},
    },
  },
}
