return {
  {
    "mason-org/mason.nvim",
    enabled = require("env").use_mason,
    -- Loaded only when a :Mason* command is used, or when mason-tool-installer
    -- (below) needs it as a dependency. Nothing loads it at startup.
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonUpdate", "MasonLog" },
    opts = {}, -- keep defaults: PATH = "prepend" is what exposes tools to Neovim
    config = function(_, opts)
      require("mason").setup(opts)
      -- after a tool finishes installing, re-trigger FileType so newly
      -- installed LSP servers can attach to buffers that were already open
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = require("env").use_mason,
    dependencies = { "mason-org/mason.nvim" },
    -- LazyFile: deferred file events (see lua/config/lazy.lua), so installing
    -- tools never blocks the initial UI. VeryLazy is the fallback for
    -- sessions started without a file (LazyFile never fires then).
    event = { "LazyFile", "VeryLazy" },
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
      },
      run_on_start = true,
      start_delay = 3000,
      auto_update = false,
    },
  },
}
