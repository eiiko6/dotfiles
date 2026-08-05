-- Variables
mainMod = "SUPER"
terminal = "kitty -o allow_remote_control=yes -o enabled_layouts=tall"
secondaryTerminal = "st"
browser = "env MOZ_ENABLE_WAYLAND=1 firefox"
fileManager = "thunar"

waybarScript = "~/.config/scripts/toggle-waybar.sh"
gamemodeScript = "~/.config/hypr/scripts/gamemode.sh"
idleScript = "~/.config/hypr/scripts/idle.sh"
lockScript = "~/.config/hypr/scripts/lock.sh"
mediaScript = "~/.config/scripts/controls"
screenshotScript = "~/.config/scripts/screenshot.sh"
palette = "~/.config/scripts/palette/generate-wallpaper-previews.sh"
emojiPickerScript = "~/.config/scripts/emoji-picker.sh"

-- Execute background apps at launch
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("~/.config/scripts/start-portal.sh")
	-- hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'BreezeX-RosePine-Linux'")
	-- hl.exec_cmd("awww-daemon")
	hl.exec_cmd("thunar --daemon")
	-- hl.exec_cmd("waybar")
	-- hl.exec_cmd("hypridle")
	-- hl.exec_cmd("mako")
	-- hl.exec_cmd("wireplumber")
	-- hl.exec_cmd("blueman-applet")
	-- hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("wl-paste --watch cliphist store")
	-- hl.exec_cmd("~/.config/waybar/scripts/album_art.sh")
	-- hl.exec_cmd("~/Desktop/scripts/wayBarIconAnimation.sh")
	hl.exec_cmd(palette .. " --all")
	hl.exec_cmd("noctalia")
end)

-- Behavior and Settings
hl.config({
	input = {
		kb_layout = "us,fr",
		kb_options = "grp:caps_toggle",
		repeat_delay = 300,
		repeat_rate = 50,
		-- kb_options = "caps:none",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
		},
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		-- accel_profile = "flat"
	},
	cursor = {
		inactive_timeout = 2,
	},
	-- dwindle = {
	--     pseudotile = true, -- Bound to mainMod + P
	--     preserve_split = true,
	-- },
	master = {
		new_status = "master",
	},
	debug = {
		-- overlay = true
	},

	misc = {
		initial_workspace_tracking = 0,
	},

	dwindle = {
		preserve_split = true,
	},
})

-- Source config files using loadfile
local config_dir = os.getenv("HOME") .. "/.config/hypr/"

-- require("noctalia").apply_theme()

require("keymaps")
require("rules")

require("appearance")
require("animations")
require("env_var")

loadfile(os.getenv("HOME") .. "/private/hyprland.lua")()
