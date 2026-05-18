hl.config({
    general = {
        gaps_in = -1,
        gaps_out = 0,
        border_size = 2,

        layout = "dwindle"
    },

    env = {
        "GTK_THEME,rose-pine-dawn-gtk"
    },

    misc = {
        disable_hyprland_logo = true
    },

    decoration = {
        rounding = 0,

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            new_optimizations = true,
            brightness = 1,
            contrast = 0.97,
            noise = 0.0117,
            ignore_opacity = true,
            popups = true,
            -- xray = true
        },

        shadow = {
            enabled = false
        }
    }
})

-- hl.layerrule({ rule = "blur", filter = "lockscreen" })
-- hl.layerrule({ rule = "blur", filter = "wofi" })

loadfile(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua")()
