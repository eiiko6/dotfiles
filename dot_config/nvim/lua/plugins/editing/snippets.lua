return {
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
    dependencies = {
      --    See the README about individual language/framework/plugin snippets:
      --    https://github.com/rafamadriz/friendly-snippets
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    config = function()
      local ls = require 'luasnip'
      local s = ls.snippet
      local t = ls.text_node

      ls.add_snippets('rust', {
        -- Generate base clap derive structure
        s('cli', {
          t {
            'use clap::Parser;',
            '',
            '#[derive(Parser, Debug)]',
            '#[command(author, version, about, long_about = None)]',
            'pub struct Cli {',
            '\t/// Input string',
            '\t#[arg(short, long)]',
            '\tinput: String,',
            '',
            '\t/// Verbose mode',
            '\t#[arg(short, long)]',
            '\tverbose: bool,',
            '}',
          },
        }),
      }, { key = 'rust' })

      -- Global snippet for inserting the current date/time.
      -- ls.add_snippets('all', {
      --   s('datetime', {
      --     f(function()
      --       return os.date '%Y-%m-%d %H:%M'
      --     end, {}),
      --   }),
      -- }, { key = 'datetime' })
    end,
  },
}
