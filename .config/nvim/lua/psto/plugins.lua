return require('packer').startup(function()
  -- Packer
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'

  -- Async building & commands
  -- use { 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }

  -- Utility Plugins
  use 'tpope/vim-surround'
  use 'sindrets/diffview.nvim'
  use 'jiangmiao/auto-pairs'
  use 'tomtom/tcomment_vim'
  use 'metakirby5/codi.vim'
  use 'github/copilot.vim'
  -- use {'neoclide/coc.nvim', branch = 'release' }
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'psto.alpha.themes.startify'.opts)
    end
  }

  -- Search
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Git
  use 'tpope/vim-fugitive'

  -- Pretty symbols
  use 'kyazdani42/nvim-web-devicons'

  -- Completion and linting
  use {
    'neovim/nvim-lspconfig'
    'hrsh7th/nvim-cmp'
    -- 'L3MON4D3/LuaSnip'
    -- 'saadparwaiz1/cmp_luasnip'
    'hrsh7th/cmp-buffer'
    'hrsh7th/cmp-nvim-lsp'
    'hrsh7th/cmp-path'
    'hrsh7th/vim-vsnip'
    'hrsh7th/vim-vsnip-integ'
    'rafamadriz/friendly-snippets'
  }

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Documentation
  -- use {
  --   'danymat/neogen',
  --   requires = 'nvim-treesitter',
  --   config = [[require('config.neogen')]],
  --   keys = { '<localleader>d', '<localleader>df', '<localleader>dc' },
  -- }

  -- Completion
  -- use {
  --   'hrsh7th/nvim-cmp',
  --   requires = {
  --     'L3MON4D3/LuaSnip',
  --     { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  --     'hrsh7th/cmp-nvim-lsp',
  --     { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
  --     { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
  --     { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
  --   },
  --   config = [[require('config.cmp')]],
  --   event = 'InsertEnter *',
  -- }

  -- Navigation
  use 'christoomey/vim-tmux-navigator'
  use 'karb94/neoscroll.nvim'

  use 'dracula/vim'
  use 'EdenEast/nightfox.nvim'

  -- diagnostics
  use 'folke/trouble.nvim'

  -- formatting
  use 'godlygeek/tabular'
  use 'sbdchd/neoformat'

  -- Statusline
  use 'nvim-lualine/lualine.nvim'

  -- Writing mode
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'

end)
