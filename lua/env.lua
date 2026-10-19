local M = {}

M.is_codespaces = vim.env.CODESPACES == "true"
M.is_termux = vim.env.TERMUX_VERSION ~= nil or (vim.env.PREFIX or ""):find("com.termux", 1, true) ~= nil

-- Mason only in Codespaces, never on Termux.
-- Other environments default to OFF. Override with NVIM_USE_MASON=1.
M.use_mason = (M.is_codespaces and not M.is_termux) or vim.env.NVIM_USE_MASON == "1"

return M
