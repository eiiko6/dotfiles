return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opt = {},
  keys = {
    -- stylua: ignore
    { "s", mode = {"n"}, function () require("flash").jump() end, desc = "Flash" },
  },
}
