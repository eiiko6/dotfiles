return {
  {
    'catppuccin/nvim',
    priority = 1000,
    name = 'catppuccin',
    opts = {
      flavour = 'macchiato',
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.pink },

          NormalFloat = { bg = 'NONE' },
          Pmenu = { bg = 'NONE' },
          FloatBorder = { bg = 'NONE' },

          TelescopeBorder = { bg = 'NONE' },
          TelescopeNormal = { bg = 'NONE' },

          -- CursorLine = { bg = "NONE" },
        }
      end,
    },
    dependencies = {
      {
        'akinsho/bufferline.nvim',
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ''):find 'catppuccin' then
            opts.highlights = require('catppuccin.special.bufferline').get()
          end
        end,
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    'folke/tokyonight.nvim',
    lazy = true,
  },
}
