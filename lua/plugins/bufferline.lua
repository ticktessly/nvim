return {
  "akinsho/bufferline.nvim",
  event = { "BufAdd", "BufDelete" },
  version = false,
  opts = {},
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  },
}
