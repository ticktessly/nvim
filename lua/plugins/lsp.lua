return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false, -- don't let Mason manage this one
        },
      },
    },
  },
}
