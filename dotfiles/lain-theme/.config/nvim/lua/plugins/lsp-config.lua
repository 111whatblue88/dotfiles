return {
  {
    "neovim/nvim-lspconfig",
    opts = {

      servers = {

        stylua = { enabled = false },
        lua_ls = {
          mason = false,
          enabled = false
        },
      },
    },
  },
}
