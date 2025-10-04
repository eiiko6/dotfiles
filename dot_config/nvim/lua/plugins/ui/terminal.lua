return {
  'folke/snacks.nvim',
  keys = {
    {
      '<C-/>',
      function()
        require('snacks.terminal').toggle(nil, {
          win = { style = 'terminal', position = 'bottom', size = 15 },
        })
      end,
      desc = 'Toggle Snacks Terminal',
    },

    {
      '<C-/>',
      function()
        vim.cmd 'stopinsert'
        require('snacks.terminal').toggle(nil, {
          win = { style = 'terminal', position = 'bottom', size = 15 },
        })
      end,
      mode = 't',
      desc = 'Toggle Snacks Terminal from terminal',
    },
  },
  opts = {
    terminal = {
      win = { style = 'terminal' },
      shell = vim.o.shell,
      env = { CLEAN_FISH = 'true' },
    },
  },
}
