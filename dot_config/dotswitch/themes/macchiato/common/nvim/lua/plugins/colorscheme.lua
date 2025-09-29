return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		opts = {
			flavour = "macchiato",
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dashboard = true,
				flash = true,
				fzf = true,
				grug_far = true,
				gitsigns = true,
				headlines = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				leap = true,
				lsp_trouble = true,
				mason = true,
				markdown = true,
				mini = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				neotree = true,
				noice = true,
				notify = true,
				semantic_tokens = true,
				snacks = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		},
		specs = {
			{
				"akinsho/bufferline.nvim",
				optional = true,
				opts = function(_, opts)
					if (vim.g.colors_name or ""):find("catppuccin") then
						opts.highlights = require("catppuccin.special.bufferline").get()
					end
				end,
			},
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},

	-- Override Lualine inside its plugin definition
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local custom_colors = {
				background = "#1e1e2e",
				black = "#1e1e2e",
				red = "#f38ba8",
				green = "#a6e3a1",
				yellow = "#f9e2af",
				blue = "#89b4fa",
				magenta = "#cba6f7",
				cyan = "#94e2d5",
				white = "#cdd6f4",
				grey = "#45475a",
			}

			local custom_theme = {
				normal = {
					a = { fg = custom_colors.background, bg = custom_colors.blue },
					b = { fg = custom_colors.white, bg = custom_colors.grey },
					c = { fg = custom_colors.white, bg = custom_colors.background },
				},
				insert = { a = { fg = custom_colors.background, bg = custom_colors.green } },
				visual = { a = { fg = custom_colors.background, bg = custom_colors.magenta } },
				replace = { a = { fg = custom_colors.background, bg = custom_colors.red } },
				inactive = {
					a = { fg = custom_colors.grey, bg = custom_colors.background },
					b = { fg = custom_colors.grey, bg = custom_colors.background },
					c = { fg = custom_colors.grey, bg = custom_colors.background },
				},
			}

			-- Apply the override
			opts.options.theme = custom_theme
			opts.options.component_separators = ""
			opts.options.section_separators = { left = "", right = "" }
		end,
	},
}
