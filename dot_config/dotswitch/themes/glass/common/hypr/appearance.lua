hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,

		col = {
			active_border = "rgba(965ff599)",
			inactive_border = "rgba(8a51ed55)",
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
		rounding_power = 2,

		blur = {
			enabled = true,
			size = 0,
			passes = 6,
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
			-- enabled = true,
			-- range = 4,
			-- render_power = 3,
			-- color = "#1a1a1aee",
		},
	},
})

-- hl.layerrule({ rule = "blur", filter = "lockscreen" })
-- hl.layerrule({ rule = "blur", filter = "wofi" })

loadfile(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua")()
