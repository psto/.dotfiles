return require('packer').startup(function()
  local use = require('packer').use
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

  -- Search
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Git
  use 'tpope/vim-fugitive'
  -- Async signs!
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Pretty symbols
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup { default = true }
    end
  }

  -- Completion and linting
  use {
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    -- 'L3MON4D3/LuaSnip',
    -- 'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
    'rafamadriz/friendly-snippets',
  }

-- Plug 'folke/lsp-colors.nvim'
-- Plug 'onsails/lspkind-nvim'
-- Plug 'williamboman/nvim-lsp-installer'

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        indent = { enable = true },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      }
    end
  }

  -- Documentation
  -- use {
  --   'danymat/neogen',
  --   requires = 'nvim-treesitter',
  --   config = [[require('config.neogen')]],
  --   keys = { '<localleader>d', '<localleader>df', '<localleader>dc' },
  -- }

  -- Navigation
  use 'christoomey/vim-tmux-navigator'
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {}
    end
  }

  -- Diagnostics
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  -- Formatting
  use 'godlygeek/tabular'
  use 'sbdchd/neoformat'

  -- Themes
  use 'dracula/vim'
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup {
        options = {
          theme = 'nightfox',
          component_separators = '',
          section_separators = '',
        },
      }
    end
  }

  -- Starting screen
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      -- require'alpha'.setup(require'psto.alpha.themes.startify'.opts)
      require'alpha'.setup(require'psto.alpha.themes.dashboard'.opts)
    end
  }

  -- Pretty colors
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }

  -- Writing mode
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          options = {
            relativenumber = false, -- disable relative numbers
            number = false, -- disable number column
            cursorline = false, -- disable cursorline
          },
        plugins = {
          twilight = { enabled = true }, -- start Twilight when zen mode opens
        },
      }
    }
    end,
  }
  use {
    -- background issue fix https://github.com/folke/twilight.nvim/issues/15
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#1F2430" },
        }
      }
    end
  }
end)
