return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        stylua = {
          command = "stylua", -- picks up the one in $PATH, not Mason's
        },
      },
    },
  },
}
