---@brief nvim-lint

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

vim.pack.add({ gh("mfussenegger/nvim-lint") }, no_load)

local load = make_loader({ "nvim-lint" }, function()
  local lint = require("lint")
  lint.linters_by_ft = {
    go = { "golangcilint" },
    sql = { "sqlfluff" },
    lua = { "luacheck" },
  }

  -- unchanged from the old `config` function
  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })
end)

-- was: event = { "BufReadPost", "BufWritePost", "BufNewFile" }
for _, event in ipairs({ "BufReadPost", "BufWritePost", "BufNewFile" }) do
  vim.api.nvim_create_autocmd(event, {
    desc = "Lazy: nvim-lint",
    once = true,
    callback = load, -- shared loader
  })
end