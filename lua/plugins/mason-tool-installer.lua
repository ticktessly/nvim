return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    ensure_installed = {
      "typescript-language-server",
      "eslint-lsp",
      "json-lsp",
      "prettier",
    },
    auto_update = false,
    run_on_start = true,
  },
}
