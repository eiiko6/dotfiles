-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader>o", function()
  local song = vim.fn.system("playerctl -p spotify metadata --format='\"{{title}}\"; {{artist}}'"):gsub("\n", "")
  vim.api.nvim_put({ song }, "c", true, true)
end, { desc = "Insert current Spotify song" })

vim.api.nvim_create_user_command("W", "w", {})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
