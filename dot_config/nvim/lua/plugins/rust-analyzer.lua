return {
  {
    "neovim/nvim-lspconfig",
    ft = "rust",
    config = function()
      require("lspconfig").rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            rustfmt = {
              overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
            },
            procMacro = {
              ignored = {
                leptos_macro = {
                  -- "component",
                  "server",
                },
              },
            },
          },
        },
      })
    end,
  },
}
