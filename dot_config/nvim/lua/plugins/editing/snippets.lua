return {
  "nvim-mini/mini.snippets",
  opts = function()
    local mini_snippets = require("mini.snippets")
    local gen_loader = mini_snippets.gen_loader

    mini_snippets.setup({
      snippets = {
        -- Load custom file with global snippets first
        gen_loader.from_file("~/.config/nvim/snippets/global.json"),

        -- Load snippets based on current language by reading files from
        -- "snippets/" subdirectories from 'runtimepath' directories.
        gen_loader.from_lang(),
      },
    })
  end,
}
