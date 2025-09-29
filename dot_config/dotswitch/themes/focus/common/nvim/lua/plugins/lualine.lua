-- plugins/lualine.lua
local function load_pywal_colors()
	local pywal_file = io.open(os.getenv("HOME") .. "/.cache/wal/colors", "r")
	if not pywal_file then
		return nil
	end

	local colors = {}
	for line in pywal_file:lines() do
		table.insert(colors, line)
	end
	pywal_file:close()
	return {
		background = colors[1], -- Transparent
		black = colors[1],
		red = colors[3],
		green = colors[4],
		yellow = colors[5],
		blue = colors[6],
		magenta = colors[7],
		cyan = colors[8],
		white = "#c6c6c6",
		grey = "#303030",
		highlight1 = colors[11], -- Additional
		highlight2 = colors[12], -- Additional
	}
end

local pywal_colors = load_pywal_colors()
	or {
		background = "#080808",
		black = "#080808",
		red = "#ff5189",
		green = "#79dac8",
		yellow = "#b4b8e6",
		blue = "#80a0ff",
		magenta = "#d183e8",
		cyan = "#79dac8",
		white = "#c6c6c6",
		grey = "#303030",
	}

local pywal_theme = {
	normal = {
		a = { fg = pywal_colors.background, bg = pywal_colors.blue },
		b = { fg = pywal_colors.white, bg = pywal_colors.grey },
		c = { fg = pywal_colors.white, bg = pywal_colors.background },
	},
	insert = { a = { fg = pywal_colors.background, bg = pywal_colors.green } },
	visual = { a = { fg = pywal_colors.background, bg = pywal_colors.magenta } },
	replace = { a = { fg = pywal_colors.background, bg = pywal_colors.red } },
	inactive = {
		a = { fg = pywal_colors.grey, bg = pywal_colors.background },
		b = { fg = pywal_colors.grey, bg = pywal_colors.background },
		c = { fg = pywal_colors.grey, bg = pywal_colors.background },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = pywal_theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { "filename", "branch" },
				lualine_c = { "%=" },
				lualine_x = {
					{ "mode", separator = { left = "" }, right_padding = 2 },
					function()
						local reg = vim.fn.reg_recording()
						if reg ~= "" then
							return "recording on " .. reg
						end
						return ""
					end,
				},
				lualine_y = { "filetype", "progress" },
				lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
