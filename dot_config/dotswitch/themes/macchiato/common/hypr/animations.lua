-- Global enable/disable for animations
hl.config({
    animations = {
        enabled = true
    }
})

-- Curves
hl.curve("myBezier", { type = "bezier", points = { { 0, 0 }, { 0.14, 0.99 } } })
hl.curve("myBezierReverse", { type = "bezier", points = { { 0.71, 0.04 }, { 1, 1 } } })

-- Animation Rules
hl.animation({ leaf = "fadeIn", enabled = false })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border", enabled = false })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "myBezier" })

hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 3, bezier = "myBezier" })

hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "myBezier", style = "slidefadevert -50%" })
