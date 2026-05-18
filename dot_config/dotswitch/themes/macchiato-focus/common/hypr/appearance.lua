-- Catppuccin Macchiato
local blue = "rgb(8aadf4)"
local mantle = "rgb(1e2030)"

hl.config({
    general = {
        gaps_in = -1,
        gaps_out = 0,
        border_size = 0,

        col = {
            active_border = blue,
            inactive_border = mantle,
        },

        layout = "dwindle"
    },

    env = {
        "GTK_THEME,Adwaita-dark"
    },

    misc = {
        disable_hyprland_logo = true
    },

    decoration = {
        rounding = 0,

        blur = {
            enabled = false
        },

        shadow = {
            enabled = false
        }
    }
})
