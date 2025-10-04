return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Blame current line
      map("n", "<leader>gb", gs.blame_line, "Git Blame Line")

      -- Blame file
      map("n", "<leader>gB", gs.blame, "Git Blame")
    end,
  },
}
