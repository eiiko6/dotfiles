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

if hl.plugin.hyprglass then
    local hg = hl.plugin.hyprglass

    hg.config({
        enabled = true,
        layers = { enabled = true },

        tint_color = 0x00000000,

        brightness = 0.0,
        contrast = 1.0,
        saturation = 1.0,
        vibrancy = 0.0,
        blur_strength = 0.0,

        dark = {
            brightness = 1.0,
            contrast = 1.0,
            saturation = 1.0,
            adaptive_dim = 0.0
        },
        -- light = {
        --     brightness = 1.0,
        --     contrast = 1.0,
        --     saturation = 1.0,
        --     adaptive_boost = 0.0
        -- },

        refraction_strength = 2.0,
        chromatic_aberration = 0.25,
        lens_distortion = 1.0,
        edge_thickness = 0.10,
        fresnel_strength = 0.25,
        specular_strength = 2.0,
    })

    -- hl.window_rule({
    --     match = { class = "kitty" },
    --     tag = "+hyprglass_enabled",
    --     border_size = 0
    -- })
    -- hl.window_rule({
    --     match = { class = "org.gnome.Nautilus" },
    --     tag = "+hyprglass_enabled",
    --     border_size = 0
    -- })
end

-- ACTUAL GLASS ===================================

hl.layer_rule({
    name = "noctalia-no-blur",
    match = {
        namespace = "^noctalia-",
    },
    blur = false,
    ignore_alpha = 0,
    blur_popups = false,
})

hl.config({
    decoration = {
        blur = {
            enabled = false,
        }
    }
})

hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { "monitor_w * 0.8", "monitor_h * 0.8" },
    opacity = "0.8"
})
