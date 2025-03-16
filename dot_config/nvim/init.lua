-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
})
