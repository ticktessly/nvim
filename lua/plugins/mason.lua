return {
  {
    "mason-org/mason.nvim",
    enabled = require("env").use_mason,
    lazy = false,
    opts = {}, -- keep defaults: PATH = "prepend" is what exposes tools to Neovim
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = require("env").use_mason,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",
        "emmylua_ls",
        "sqls",

        "gofumpt",
        "goimports",
        "stylua",
        "shfmt",
        "sqlfluff",

        "golangci-lint",
        "luacheck",
      },
      run_on_start = true,
      start_delay = 3000,
      auto_update = false,
    },
  },
}
