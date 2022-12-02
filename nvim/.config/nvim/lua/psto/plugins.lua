local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_augroup("SyncPackerPlugins", {})
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerSync", pattern = "plugins.lua", group = "SyncPackerPlugins" }
)

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

return packer.startup(function(use)
  -- Packer
  use("wbthomason/packer.nvim")
  use("lewis6991/impatient.nvim")

  -- Utility Plugins
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  })
  use({
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  })
  use({
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  })
  use("akinsho/toggleterm.nvim")

  -- Comments
  use("JoosepAlviste/nvim-ts-context-commentstring") -- jsx/tsx comment support
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  })
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

  -- Search
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use { "nvim-telescope/telescope-ui-select.nvim" }
  use({
    "nvim-pack/nvim-spectre",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  -- Git
  -- Async signs!
  use({ "lewis6991/gitsigns.nvim" })

  -- Pretty symbols
  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  })

  -- LSP
  use({
    "neovim/nvim-lspconfig", -- enable LSP
    -- "williamboman/nvim-lsp-installer"
  })
  use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" })

  -- Completion cmp plugins
  use({
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  })

  -- Snippets
  use({
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "psto/friendly-snippets",
  })

  -- Highlights
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("p00f/nvim-ts-rainbow")

  -- Navigation
  use("ThePrimeagen/harpoon")
  use({
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({})
    end,
  })
  use("folke/which-key.nvim")

  -- Diagnostics
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  })

  -- Formatting
  -- use("godlygeek/tabular")
  use("onsails/lspkind-nvim")
  use("lukas-reineke/lsp-format.nvim")
  use("lukas-reineke/indent-blankline.nvim")

  -- REST client
  use({
    "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Themes
  use("folke/tokyonight.nvim")

  -- Statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  })

  -- Starting screen
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })

  -- Pretty colors for css, tailwindcss
  use({
    "mrshmllow/document-color.nvim",
    config = function()
      require("document-color").setup({
        mode = "background", -- "background" | "foreground" | "single"
      })
    end,
  })

  -- Writing mode
  use({ "folke/zen-mode.nvim" })
  use({ "folke/twilight.nvim" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
