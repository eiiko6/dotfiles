-- [[ Options ]]

-- Disable swapfiles
-- vim.opt.swapfile = false

-- Set indentation width
vim.opt.tabstop = 2

-- Disable line wrap
vim.o.wrap = false

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set shell for terminals
vim.o.shell = '/usr/bin/fish'

-- Use terminal colors
vim.o.termguicolors = true

-- Use terminal nerd font
vim.g.have_nerd_font = true

-- Enable line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Hide mode
vim.o.showmode = false

-- Hide status
vim.opt.laststatus = 3

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 400

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Set how neovim will display certain whitespace characters in the editor
vim.o.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Show which line the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Enable validation dialog
vim.o.confirm = true

-- Hide ~ characters on empty lines
vim.opt.fillchars = { eob = ' ' }

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Autocommands ]]

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

require('lazy').setup {
  { import = 'plugins' },
  { import = 'plugins.colors' },
  { import = 'plugins.editing' },
  { import = 'plugins.lsp' },
  { import = 'plugins.ui' },
}

require 'keymaps'
-- require 'health'
