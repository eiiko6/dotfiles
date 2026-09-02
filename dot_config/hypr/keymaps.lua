-- Close the active window
hl.bind(mainMod .. " + " .. "C", hl.dsp.window.close())
-- Fulscreen the active window
hl.bind(mainMod .. " + " .. "F", hl.dsp.window.fullscreen())
-- dwindle
hl.bind(mainMod .. " + " .. "P", hl.dsp.window.pseudo())
-- dwindle
hl.bind(mainMod .. " + " .. "U", hl.dsp.layout("togglesplit"))
-- Exit Hyprland all together no (force quit Hyprland)
hl.bind(mainMod .. " + SHIFT + " .. "M", hl.dsp.exit())
-- Reload hyprland
hl.bind(mainMod .. " + " .. "R", hl.dsp.exec_cmd('hyprctl reload && notify-send "Hyprland reloaded!"'))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + " .. "H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + " .. "L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + " .. "K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + " .. "J", hl.dsp.focus({ direction = "d" }))

-- Swap windows with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + " .. "H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + " .. "L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + " .. "K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + " .. "J", hl.dsp.window.swap({ direction = "d" }))

-- Resize windows
hl.bind(mainMod .. " + CONTROL + " .. "H", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + CONTROL + " .. "L", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(mainMod .. " + CONTROL + " .. "K", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + CONTROL + " .. "J", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + " .. "ESCAPE", hl.dsp.workspace.toggle_special("terminal"))
hl.bind(mainMod .. " + SHIFT + " .. "ESCAPE", hl.dsp.window.move({ workspace = "special:terminal" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + " .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + " .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch focus between monitors
hl.bind(mainMod .. " + " .. "Tab", hl.dsp.window.cycle_next({ next = true }))
hl.bind(mainMod .. " + SHIFT + " .. "Tab", hl.dsp.window.cycle_next({ next = false }))

-- Center and float windows
hl.bind(mainMod .. " + " .. "V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + " .. "C", function()
	local m = hl.get_active_monitor()
	hl.dispatch(hl.dsp.window.float({ action = "enable" }))
	hl.dispatch(hl.dsp.window.resize({ x = m.width * 0.73, y = m.height * 0.73, relative = false }))
	hl.dispatch(hl.dsp.window.center())
end)

-- Launch small utilities
-- bind = $mainMod, SPACE, exec, wofi -H 600 -- App launcher
-- hl.bind(mainMod .. " + " .. "SPACE", hl.dsp.exec_cmd("fuzzel")) -- App launcher
hl.bind(mainMod .. " + " .. "SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher")) -- App launcher
hl.bind(mainMod .. " + " .. "X", hl.dsp.exec_cmd(lockScript)) -- Screen lock
hl.bind(mainMod .. " + SHIFT + " .. "P", hl.dsp.exec_cmd("hyprpicker -a -f hex")) -- Color picker
-- bind = $mainMod_SHIFT, V, exec, cliphist list | wofi -S dmenu -W 500 -H 300 | cliphist decode | wl-copy
hl.bind(mainMod .. " + SHIFT + " .. "V", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + " .. "S", hl.dsp.exec_cmd(screenshotScript))
hl.bind(mainMod .. " + SHIFT + " .. "S", hl.dsp.exec_cmd(screenshotScript .. " full"))
hl.bind(mainMod .. " + CONTROL + " .. "S", hl.dsp.exec_cmd(screenshotScript .. " editor"))
hl.bind(
	mainMod .. " + " .. "SEMICOLON",
	hl.dsp.exec_cmd("~/.config/scripts/palette/change-wallpaper-menu.sh --noctalia")
)
hl.bind(
	mainMod .. " + SHIFT + " .. "SEMICOLON",
	-- hl.dsp.exec_cmd("~/.config/scripts/palette/change-wallpaper-menu.sh --fuzzel")
	hl.dsp.exec_cmd("~/.config/scripts/palette/change-wallpaper-menu.sh --noctalia-wallhaven")
)

-- Launch apps
hl.bind(mainMod .. " + " .. "Q", hl.dsp.exec_cmd(terminal)) -- Main terminal
hl.bind(mainMod .. " + SHIFT + " .. "Q", hl.dsp.exec_cmd("env CLEAN_FISH=true kitty"))
hl.bind(
	mainMod .. " + " .. "ESCAPE",
	hl.dsp.exec_cmd("hyprctl clients | grep specialterminal || kitty --class specialterminal --hold -e btop")
)
hl.bind(mainMod .. " + " .. "T", hl.dsp.exec_cmd(secondaryTerminal)) -- Secondary terminal
hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd(fileManager)) -- File manager
hl.bind(mainMod .. " + " .. "I", hl.dsp.exec_cmd(browser)) -- Browser
-- hl.bind(mainMod .. " + SHIFT + " .. "I", hl.dsp.exec_cmd(privateBrowser))
hl.bind(mainMod .. " + " .. "O", hl.dsp.exec_cmd("gtk-launch obsidian")) -- Obsidian
hl.bind(mainMod .. " + " .. "D", hl.dsp.exec_cmd("qalculate-gtk")) -- Calculator

-- Scripts
hl.bind(mainMod .. " + " .. "N", hl.dsp.exec_cmd(waybarScript)) -- Launch or kill waybar
-- hl.bind(mainMod .. " + " .. "G", hl.dsp.exec_cmd(gamemodeScript)) -- Toggle some hyprland visual effects
-- hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd(idleScript)) -- mkdir -p "$HOME/Pictures/Screenshots"Launch or kill hypridle
-- bind = $mainMod, W, exec, fish -c 'source ~/.config/fish/functions/palette.fish; set wallpaper (find $HOME/Pictures/Wallpapers/ -type f -printf "%P\n" | shuf -n 1 | sed s/.png\$//); palette "$wallpaper"' -- Set a random wallpaper form ~/Pictures/Wallpapers/
hl.bind(mainMod .. " + " .. "PERIOD", hl.dsp.exec_cmd(emojiPickerScript)) -- Dmenu emoji picker

hl.bind(mainMod .. " + SHIFT + " .. "D", hl.dsp.exec_cmd("~/private/toggle_monitors.sh"))

-- Media Binds
hl.bind(mainMod .. " + " .. "M", hl.dsp.exec_cmd("playerctl play-pause")) -- Play or pause media
hl.bind("xf86audioraisevolume", hl.dsp.exec_cmd(mediaScript .. "/volume --inc"))
hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd(mediaScript .. "/volume --dec"))
hl.bind("xf86AudioMicMute", hl.dsp.exec_cmd(mediaScript .. "/volume --toggle-mic"))
hl.bind("xf86audioMute", hl.dsp.exec_cmd(mediaScript .. "/volume --toggle"))
hl.bind("xf86MonBrightnessDown", hl.dsp.exec_cmd(mediaScript .. "/brightness --dec"))
hl.bind("xf86MonBrightnessUp", hl.dsp.exec_cmd(mediaScript .. "/brightness --inc"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
