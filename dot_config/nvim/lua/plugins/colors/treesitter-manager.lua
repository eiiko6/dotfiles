return {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    config = function()
        require("tree-sitter-manager").setup({
            ensure_installed = {
                'arduino',
                'asm',
                'awk',
                'bash',
                'c',
                'c_sharp',
                'cpp',
                'css',
                'csv',
                'gitignore',
                'html',
                'hyprlang',
                'java',
                'javadoc',
                'javascript',
                'json',
                'jsx',
                'kotlin',
                'kotlin',
                'lua',
                'luadoc',
                'make',
                'markdown',
                'markdown_inline',
                'nix',
                'php',
                'phpdoc',
                'printf',
                'python',
                'razor',
                'regex',
                'ruby',
                'rust',
                'sql',
                'ssh_config',
                'tera',
                'toml',
                'twig',
                'typescript',
                'typescript',
                'typst',
                'vim',
                'vue',
                'wgsl',
                'wgsl_bevy',
                'xml',
                'yaml',
                'zig',
            },                   -- list of parsers to install at the start of a neovim session
            -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
            auto_install = true, -- if enabled, install missing parsers when editing a new file
            -- highlight = true, -- treesitter highlighting is enabled by default
            -- languages = {}, -- override or add new parser sources
            -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
            -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
        })
    end
}
