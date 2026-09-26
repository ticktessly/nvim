vim.loader.enable()

require("config.lazy")
require("config.autocmd")
require("config.keymaps")
require("config.opts")

vim.cmd.colorscheme("catppuccin")
