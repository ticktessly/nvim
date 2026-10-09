return {
  "catppuccin/nvim",
  name = "catppuccin", -- required, the repo is just "nvim"
  lazy = false,
  priority = 1000, -- load before other plugins
  opts = {},
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
