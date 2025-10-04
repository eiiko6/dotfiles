return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'catppuccin/nvim' },
  opts = function(_, opts)
    -- use catppuccin integration
    local cp = require('catppuccin.palettes').get_palette 'macchiato'
    local custom_catppuccin = require 'lualine.themes.catppuccin'

    custom_catppuccin.normal.a.bg = cp.blue
    custom_catppuccin.insert.a.bg = cp.green
    custom_catppuccin.visual.a.bg = cp.mauve
    custom_catppuccin.replace.a.bg = cp.red

    opts.options = {
      theme = custom_catppuccin,
      component_separators = '',
      section_separators = { left = '', right = '' },
    }

    opts.sections = {
      lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
      lualine_b = { 'filename', 'branch' },
      lualine_c = { '%=' },
      lualine_x = {
        function()
          local reg = vim.fn.reg_recording()
          if reg ~= '' then
            return 'recording on ' .. reg
          end
          return ''
        end,
      },
      lualine_y = { 'filetype', 'progress' },
      lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
    }
  end,
}
