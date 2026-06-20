-- Catppuccin Macchiato
local accent = "rgb(f5c2e7)"
local accentAlpha = "f5c2e7"

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 15,
		border_size = 2,

		col = {
			active_border = accent,
			inactive_border = "rgba(" .. accentAlpha .. "60)",
		},

		layout = "dwindle",
	},

	env = {
		"GTK_THEME,Adwaita-dark",
	},

	misc = {
		disable_hyprland_logo = true,
	},

	decoration = {
		rounding = 20,

		blur = {
			enabled = true,
			size = 2,
			passes = 3,
			new_optimizations = true,
			brightness = 1,
			contrast = 1,
			noise = 0.05,
			ignore_opacity = true,
			popups = true,
			-- xray = true
		},

		shadow = {
			enabled = false,
		},
	},
})

-- hl.layerrule({ rule = "blur", filter = "lockscreen" })
-- hl.layerrule({ rule = "blur", filter = "wofi" })
