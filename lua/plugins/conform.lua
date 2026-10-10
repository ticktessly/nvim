---@brief conform.nvim

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

vim.pack.add({ gh("stevearc/conform.nvim") }, no_load)

local load = make_loader({ "conform.nvim" }, function()
  require("conform").setup({
    formatters_by_ft = {
      go = { "gofumpt", "goimports" },
      lua = { "stylua" },
      sql = { "sqlfluff", stop_after_first = true },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = { timeout_ms = 500 },
    formatters = {
      shfmt = {
        append_args = { "-i", "2" },
      },
    },
  })
end)

-- was: event = "BufWritePre"
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Lazy: conform.nvim",
  once = true,
  callback = load,
})

-- was: cmd = "ConformInfo"
-- Limitation: until loaded, the command does not exist for completion.
vim.api.nvim_create_autocmd("CmdUndefined", {
  desc = "Lazy: conform.nvim",
  pattern = "ConformInfo",
  once = true,
  callback = load,
})

-- was: keys = { { "<leader>F", ..., mode = "" } }
-- `mode = ""` is passed through verbatim: lazy handed it straight to
-- `vim.keymap.set`, which expands it to normal/visual/select/insert. Keeping the
-- literal string guarantees identical behaviour.
vim.keymap.set("", "<leader>F", function()
  load()
  require("conform").format({ async = true })
end, { desc = "Format buffer" })