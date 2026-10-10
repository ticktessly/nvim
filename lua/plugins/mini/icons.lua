---@brief mini.icons -- EAGER.
---
--- Was eager under lazy.nvim too: its `init` shim below runs at startup and
--- requires mini.icons, so lazy loaded the plugin eagerly regardless of the
--- missing `event`. mini.pairs and mini.statusline also depend on it.

local gh = require("pack_utils").gh
local opts = require("pack_utils").eager

-- was: init = function() ... end
-- Must run before `vim.pack.add`, exactly as lazy's `init` ran before the
-- plugin was loaded, so the shim is in place before anything requires
-- `nvim-web-devicons` (mini.icons is a drop-in replacement for it).
package.preload["nvim-web-devicons"] = function()
  require("mini.icons").mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end

vim.pack.add({ gh("nvim-mini/mini.icons") }, opts)

require("mini.icons").setup({})