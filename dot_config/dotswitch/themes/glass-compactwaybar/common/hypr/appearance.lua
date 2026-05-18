hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,

        layout = "dwindle"
    },

    env = {
        "GTK_THEME,Adwaita-dark"
    },

    misc = {
        disable_hyprland_logo = true
    },

    decoration = {
        rounding = 20,

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
            enabled = false
        }
    }
})

loadfile(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua")()
