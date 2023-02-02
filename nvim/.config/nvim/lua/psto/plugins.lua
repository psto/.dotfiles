-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- must be set before lazy.nvim
vim.g.maplocalleader = " "

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then return end

return lazy.setup({
  defaults = { lazy = true },
  install = { colorscheme = { "tokyonight" } },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        -- "tutor",
        "zipPlugin",
      },
    },
  },
  -- Utility Plugins
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { "akinsho/toggleterm.nvim", event = "VeryLazy" },

  -- Comments
  {
    "JoosepAlviste/nvim-ts-context-commentstring", -- jsx/tsx comment support
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Search
  { "nvim-telescope/telescope.nvim", dependencies = "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "debugloop/telescope-undo.nvim" },
  { "nvim-pack/nvim-spectre", dependencies = "nvim-lua/plenary.nvim" },

  -- Git
  { "lewis6991/gitsigns.nvim" }, -- Async signs!

  -- Pretty symbols
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig", -- enable LSP
    dependencies = {
      'j-hui/fidget.nvim', -- LSP status updates
    }
  },
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
  -- {
  --   "glepnir/lspsaga.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lspsaga").setup({})
  --   end,
  --   dependencies = { { "nvim-tree/nvim-web-devicons" } }
  -- },

  -- Completion cmp plugins
  {
    "hrsh7th/nvim-cmp",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },
  { "Exafunction/codeium.vim" },
  { "aduros/ai.vim", event = "VeryLazy" },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({})
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },

  -- Snippets
  {
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "psto/friendly-snippets",
  },

  -- Highlights
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  { "p00f/nvim-ts-rainbow" },

  -- Navigation
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },
  { "alexghergh/nvim-tmux-navigation" },
  { "ThePrimeagen/harpoon" },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({})
    end,
  },
  { "folke/which-key.nvim" },

  -- Diagnostics
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Formatting
  { "onsails/lspkind-nvim" },
  { "lukas-reineke/lsp-format.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },

  -- Debugging
  { "jayp0521/mason-nvim-dap.nvim" },
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "PatschD/zippy.nvim", event = "VeryLazy" },
  { 'michaelb/sniprun', build = 'bash ./install.sh', event = "VeryLazy" },

  -- REST client
  { "NTBBloodbath/rest.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },

  -- Themes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- load this before all the other start plugins
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" },
  -- {
  --   "folke/noice.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   }
  -- },

  -- Starting screen
  { "goolord/alpha-nvim", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Pretty colors for css, tailwindcss
  {
    "mrshmllow/document-color.nvim",
    event = "VeryLazy",
    config = function()
      require("document-color").setup({
        mode = "background", -- "background" | "foreground" | "single"
      })
    end,
  },

  -- Writing mode
  { "folke/zen-mode.nvim", event = "VeryLazy" },
  { "folke/twilight.nvim", event = "VeryLazy" },
  { "epwalsh/obsidian.nvim", event = "VeryLazy" },
})
