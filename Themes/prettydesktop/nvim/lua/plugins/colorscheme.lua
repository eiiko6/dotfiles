return {
  {
    "tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.comment = "#ffb0ee"
      end,
      on_highlights = function(hl)
        hl.LineNr = {
          fg = "#ffb0ee",
        }
        hl.LineNrAbove = {
          fg = "#ffb0ee",
        }
        hl.LineNrBelow = {
          fg = "#ffb0ee",
        }

        hl.CursorLine = {
          -- bg = "#453e57",
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
