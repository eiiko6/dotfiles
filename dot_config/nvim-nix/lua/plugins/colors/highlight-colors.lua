return {
  'norcalli/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('colorizer').setup({
      '*', -- enable for all filetypes by default
      css = { rgb_fn = true },
      html = { names = false },
    }, {})
  end,
}
