---@brief noice.nvim
---
--- The old `config` function had a lazy-UI hack:
---   `if vim.o.filetype == "lazy" then vim.cmd("messages clear") end`
--- It existed because noice shows messages from before it was enabled, and Lazy
--- was printing those while installing plugins. There is no lazy UI any more, so
--- it is gone.
---
--- noice is loaded unconditionally on `UIEnter`, which is long before any of its
--- mappings can be pressed, so the mappings below are defined directly as their
--- final form rather than as lazy stubs.

local P = require("pack_utils")
local gh, no_load, make_loader = P.gh, P.no_load, P.make_loader

vim.pack.add({ gh("folke/noice.nvim") }, no_load)

local load = make_loader({ "noice.nvim" }, function()
  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  })
end)

-- was: event = "VeryLazy"
vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Lazy: noice.nvim",
  once = true,
  callback = function()
    vim.schedule(load)
  end,
})

-- stylua: ignore
-- was: keys = { ... }
vim.keymap.set("n", "<leader>sn", "", { desc = "+noice" })
vim.keymap.set("c", "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, { desc = "Redirect Cmdline" })
vim.keymap.set("n", "<leader>snl", function() require("noice").cmd("last") end, { desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>snh", function() require("noice").cmd("history") end, { desc = "Noice History" })
vim.keymap.set("n", "<leader>sna", function() require("noice").cmd("all") end, { desc = "Noice All" })
vim.keymap.set("n", "<leader>snd", function() require("noice").cmd("dismiss") end, { desc = "Dismiss All" })
vim.keymap.set("n", "<leader>snt", function() require("noice").cmd("pick") end, { desc = "Noice Picker (Telescope/FzfLua)" })
vim.keymap.set({ "i", "n", "s" }, "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, { silent = true, expr = true, desc = "Scroll Forward" })
vim.keymap.set({ "i", "n", "s" }, "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, { silent = true, expr = true, desc = "Scroll Backward" })