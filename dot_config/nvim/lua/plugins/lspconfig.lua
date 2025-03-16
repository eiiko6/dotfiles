return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      autoformat = false,
      servers = {
        jdtls = {
          -- Your custom jdtls settings
          handlers = {
            ["$/progress"] = function(_, _, _) end,
          },
        },
        rust_analyzer = {
          enabled = true,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      },
    },
  },
}
