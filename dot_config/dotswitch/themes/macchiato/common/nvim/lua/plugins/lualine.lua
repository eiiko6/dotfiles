return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'catppuccin/nvim' },
    opts = function()
        local cp = require('catppuccin.palettes').get_palette('macchiato')

        local custom_catppuccin = require('catppuccin.utils.lualine')()

        custom_catppuccin.normal.a.bg = cp.blue
        custom_catppuccin.insert.a.bg = cp.green
        custom_catppuccin.visual.a.bg = cp.mauve
        custom_catppuccin.replace.a.bg = cp.red

        return {
            options = {
                theme = custom_catppuccin,
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { 'filename', 'branch' },
                lualine_c = { '%=' },
                lualine_x = {
                    function()
                        local reg = vim.fn.reg_recording()
                        return reg ~= '' and 'recording on ' .. reg or ''
                    end,
                },
                lualine_y = { 'filetype', 'progress' },
                lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
            },
        }
    end,
}
