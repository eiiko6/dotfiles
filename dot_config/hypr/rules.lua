-- Audacious
hl.window_rule({
	name = "Audacious",
	match = { class = "^(Audacious)$" },
	float = true,
	center = true,
})

-- Blueman Manager
hl.window_rule({
	name = "Blueman Manager",
	match = { class = "^(blueman-manager)$" },
	float = true,
})

-- Firefox
-- hl.window_rule({ match = { class = "^(Firefox)$" }, opacity = "0.8 0.8" })
-- hl.window_rule({ match = { class = "firefox" }, opacity = "0.7" })

-- Kitty
hl.window_rule({
	name = "Kitty",
	match = { class = "^(kitty)$" },
	size = { "monitor_w * 0.8", "monitor_h * 0.8" },
})
-- hl.window_rule({ match = { class = "^(kitty)$" }, float = true })
-- hl.window_rule({ match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })
-- hl.window_rule({ match = { class = "^(kitty)$" }, opacity = "0.8 0.8" })
-- hl.window_rule({ match = { class = "^(kitty)$", title = "^(update-sys)$" }, animation = "popin" })

-- Matplotlib
hl.window_rule({
	name = "Matplotlib",
	match = { class = "^(org.matplotlib.Matplotlib3)$" },
	float = true,
	size = "70% 70%",
})

-- MPV
hl.window_rule({
	name = "MPV",
	match = { class = "^(mpv)$" },
	float = true,
	size = { "monitor_w * 0.8", "monitor_h * 0.8" },
})

-- MuPDF
hl.window_rule({
	name = "MuPDF",
	match = { class = "^(MuPDF)$" },
	float = true,
	center = true,
})

-- IMV
hl.window_rule({
	name = "IMV",
	match = { class = "^(imv)$" },
	float = true,
	center = true,
	size = { "monitor_w * 0.9", "monitor_h * 0.9" },
})

-- Gwenview
hl.window_rule({
	name = "Gwenview",
	match = { class = "^(org.kde.gwenview)$" },
	float = true,
	center = true,
	size = { "monitor_w * 0.9", "monitor_h * 0.9" },
})

-- Network Manager
hl.window_rule({
	name = "Network Manager",
	match = { class = "^(nm-connection-editor)$" },
	float = true,
})

-- Notifications
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, ignore_alpha = 0 })

-- Obsidian
-- hl.window_rule({ match = { class = "^(obsidian)$" }, opacity = "0.9" })

-- Pavucontrol
hl.window_rule({
	name = "Pavucontrol",
	match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol)$" },
	float = true,
	size = "60% 60%",
})

-- Spotify
hl.window_rule({
	name = "Spotify",
	match = { class = "^(spotify)$" },
	opacity = "0.8",
})

-- ST Terminal
hl.window_rule({
	name = "ST Terminal",
	match = { class = "^(st-256color)$" },
	opacity = "0.6 0.6",
	float = true,
	size = "40% 40%",
})

-- Thunar
hl.window_rule({
	name = "Thunar",
	match = { class = "^([Tt]hunar)$" },
	float = true,
	center = true,
	-- opacity = "0.7",
	opacity = "1",
	size = { "monitor_w * 0.9", "monitor_h * 0.9" },
})

-- File roller
hl.window_rule({
	name = "File Roller",
	match = { class = "^(org.gnome.FileRoller)$" },
	float = true,
	opacity = "0.7",
	size = { "monitor_w * 0.65", "monitor_h * 0.65" },
})

-- Centered floating windows
hl.window_rule({
	name = "Centered Floating Windows",
	match = { class = "^(floatingcentered)$" },
	float = true,
	center = true,
	size = { "monitor_w * 0.65", "monitor_h * 0.65" },
})

-- Small centered floating windows
hl.window_rule({
	name = "Small Floating Centered",
	match = { class = "^(smallfloatingcentered)$" },
	float = true,
	center = true,
	size = { "monitor_w * 0.3", "monitor_h * 0.3" },
})

-- Vesktop
hl.window_rule({
	name = "Vesktop",
	match = { class = "^(vesktop)$" },
	opacity = "0.75",
})

-- Discord
-- hl.window_rule({ match = { class = "^(discord)$" }, opacity = "0.75" })

-- Virt Manager
hl.window_rule({
	name = "Virt Manager",
	match = { class = "^(virt-manager)$" },
	opacity = "0.8",
	float = true,
	size = { "monitor_w * 0.8", "monitor_h * 0.8" },
})

-- VLC
hl.window_rule({
	name = "VLC",
	match = { class = "^(vlc)$" },
	float = true,
	fullscreen = true,
})

-- Wofi
hl.window_rule({
	name = "Wofi",
	match = { class = "^(wofi)$" },
	float = true,
	move = { "cursor_x - (monitor_w * 0.03)", "cursor_y - (monitor_h * 1.05)" },
	no_anim = true,
	opacity = "0.8 0.6",
})
hl.layer_rule({ match = { namespace = "wofi" }, blur = true })
hl.layer_rule({ match = { namespace = "wofi" }, ignore_alpha = 0 })

-- Fuzzel
hl.layer_rule({ match = { namespace = "launcher" }, blur = true })
hl.layer_rule({ match = { namespace = "launcher" }, dim_around = true })

-- Waybar
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, ignore_alpha = 0 })

-- Selection layers
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })

-- Special workspace
hl.window_rule({
	name = "Special Terminal",
	match = { class = "^(specialterminal)$" },
	float = true,
	center = true,
	size = { "monitor_w * 0.65", "monitor_h * 0.65" },
	workspace = "special:terminal",
})

hl.window_rule({
	name = "Genshin Impact",
	match = { class = "steam_app_3366906218" },
	confine_pointer = true,
})
