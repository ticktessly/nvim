require("config.lazy")
require("config.keymaps")
require("config.opts")
require("config.autocmd")

-- vim.lsp.enable("gopls")
-- vim.lsp.enable("emmylua_ls")

-- Defer enabling LSP: `vim.lsp` is only needed once we actually open a buffer,
-- so don't pay the module load cost on a bare `nvim`.

local lsp_enabled = false
local function enable_lsp()
  if lsp_enabled then
    return
  end
  lsp_enabled = true
  vim.lsp.enable("gopls")
  vim.lsp.enable("emmylua_ls")
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "TermOpen" }, {
  group = vim.api.nvim_create_augroup("lsp_enable", { clear = true }),
  once = true,
  desc = "Enable language servers on first buffer",
  callback = enable_lsp,
})
