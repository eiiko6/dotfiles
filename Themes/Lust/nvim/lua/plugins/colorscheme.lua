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
				colors.comment = "#ffb0b0"
			end,
			on_highlights = function(hl)
				hl.LineNr = {
					fg = "#ffb0b0",
				}
				hl.LineNrAbove = {
					fg = "#ffb0b0",
				}
				hl.LineNrBelow = {
					fg = "#ffb0b0",
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
