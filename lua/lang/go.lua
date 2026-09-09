return {
  -- Treesitter parsers for Go
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "gotmpl" })
    end,
  },

  -- LSP setup for Go (gopls)
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.lsp.enable("gopls")
    end,
  },

  -- Formatter for Go
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.go = { "gofumpt", "goimports" }
    end,
  },

  -- Linter for Go
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = { "golangcilint" }
    end,
  },

  -- Debugger for Go
  {
    "mfussenegger/nvim-dap",
    dependencies = { "leoluz/nvim-dap-go" },
    opts = function()
      require("dap-go").setup()
    end,
    keys = {
      {
        "<leader>dt",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug Test (Go)",
      },
    },
  },
}
