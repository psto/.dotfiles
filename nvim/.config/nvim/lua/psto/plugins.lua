local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'

  -- Async building & commands
  -- use { 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }

  -- Utility Plugins
  use 'tpope/vim-surround'
  use 'sindrets/diffview.nvim'
  use "windwp/nvim-autopairs"
  use 'metakirby5/codi.vim'
  use 'github/copilot.vim'
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      }
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
  -- Async signs!
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        }
      })
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
  }
  use 'p00f/nvim-ts-rainbow'

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
  use "onsails/lspkind-nvim"
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.prettier,
          require("null-ls").builtins.diagnostics.eslint,
        },
      })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Themes
  use 'dracula/vim'
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
  use 'bluz71/vim-nightfly-guicolors'
  use "rebelot/kanagawa.nvim"

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup {
        options = {
          theme = 'kanagawa',
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
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
