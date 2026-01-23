-- Basic settings
vim.opt.number = true              -- Line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.mouse = 'a'                -- Mouse support
vim.opt.clipboard = 'unnamedplus'  -- System clipboard
vim.opt.tabstop = 2                -- Tab width
vim.opt.shiftwidth = 2             -- Indent width
vim.opt.expandtab = true           -- Spaces instead of tabs
vim.opt.smartindent = true         -- Smart indentation
vim.opt.termguicolors = true       -- True color support
vim.opt.signcolumn = 'yes'         -- Always show sign column
vim.opt.updatetime = 250           -- Faster updates
vim.opt.scrolloff = 8              -- Keep 8 lines visible
vim.opt.ignorecase = true          -- Case insensitive search
vim.opt.smartcase = true           -- Unless capital letters used

-- Set leader key to space
vim.g.mapleader = ' '

-- Bootstrap lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
  -- Color scheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },

  -- Syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'python', 'javascript', 'typescript', 'json', 'yaml', 'markdown', 'bash' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        view = {
          side = 'right',
        },
	})
    end,
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'catppuccin' }
      })
    end,
  },

  -- Git signs in gutter
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- Auto pairs (brackets, quotes)
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },

  -- Comment toggling
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup()
    end,
  },
})

-- Keymaps
local keymap = vim.keymap.set

-- File explorer
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- Telescope
keymap('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Search in files' })
keymap('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'Find buffers' })

-- Window navigation
keymap('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Clear search highlight
keymap('n', '<Esc>', ':nohlsearch<CR>', { silent = true })
