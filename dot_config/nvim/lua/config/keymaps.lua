-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- paste without overwriting register content
map("x", "<leader>p", [["_dP]])

-- paste current spotify song
map("n", "<leader>o", function()
  local song = vim.fn.system("playerctl -p spotify metadata --format='\"{{title}}\"; {{artist}}'"):gsub("\n", "")
  vim.api.nvim_put({ song }, "c", true, true)
end, { desc = "Insert current Spotify song" })

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("Wqa", "wqa", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})

-- read full line diagnostics
map("n", "<leader>d", vim.diagnostic.open_float)
