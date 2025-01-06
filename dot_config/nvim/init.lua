-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("time-tracker").setup({
  data_file = vim.fn.stdpath("data") .. "/time-tracker.db",
  tracking_events = { "BufEnter", "BufWinEnter", "CursorMoved", "CursorMovedI", "WinScrolled" },
  tracking_timeout_seconds = 5 * 60, -- 5 minutes
})

require("neo-tree").setup({
  window = {
    width = 25,
  },
})
