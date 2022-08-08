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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return packer.startup(function(use)
	-- Packer
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")

	-- Utility Plugins
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end
    })
	use("sindrets/diffview.nvim")
	use("windwp/nvim-autopairs")
	use({
        "windwp/nvim-ts-autotag",
		config = function()
          require('nvim-ts-autotag').setup()
		end,
	})
	use("akinsho/toggleterm.nvim")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	})

	-- Search
	use("nvim-lua/popup.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-fzy-native.nvim")
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use({
		"nvim-pack/nvim-spectre",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

    -- use 'ggandor/lightspeed.nvim'

	-- Git
	use("tpope/vim-fugitive")
	-- Async signs!
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
					change = {
						hl = "GitSignsChange",
						text = "▎",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
					delete = {
						hl = "GitSignsDelete",
						text = "契",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					topdelete = {
						hl = "GitSignsDelete",
						text = "契",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					changedelete = {
						hl = "GitSignsChange",
						text = "▎",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
				},
			})
		end,
	})

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
		-- 'folke/lsp-colors.nvim'
		-- 'williamboman/nvim-lsp-installer'
	})
    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    })

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
		"rafamadriz/friendly-snippets",
	})

	-- Highlights
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")

	-- Documentation
	-- use {
	--   'danymat/neogen',
	--   requires = 'nvim-treesitter',
	--   config = [[require('config.neogen')]],
	--   keys = { '<localleader>d', '<localleader>df', '<localleader>dc' },
	-- }

	-- Navigation
	use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use("christoomey/vim-tmux-navigator")
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	})

	-- Diagnostics
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	-- Formatting
	use("godlygeek/tabular")
	use("onsails/lspkind-nvim")
	use("lukas-reineke/lsp-format.nvim")

	-- REST client
	use({
		"NTBBloodbath/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					show_http_info = true,
					show_headers = true,
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	})

	-- Themes
	use("dracula/vim")
	use("EdenEast/nightfox.nvim")
	use("folke/tokyonight.nvim")
	use("navarasu/onedark.nvim")
	use("bluz71/vim-nightfly-guicolors")
	use("rebelot/kanagawa.nvim")

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight",
					component_separators = "",
					section_separators = "",
                    globalstatus=true
				},
			})
		end,
	})

	-- Starting screen
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			-- require'alpha'.setup(require'psto.alpha.themes.startify'.opts)
			require("alpha").setup(require("psto.alpha.themes.dashboard").opts)
		end,
	})

	-- Pretty colors
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Writing mode
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					options = {
						relativenumber = false, -- disable relative numbers
						number = false, -- disable number column
						cursorline = false, -- disable cursorline
					},
					plugins = {
						twilight = { enabled = true }, -- start Twilight when zen mode opens
					},
				},
			})
		end,
	})
	use({
		-- background issue fix https://github.com/folke/twilight.nvim/issues/15
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				dimming = {
					alpha = 0.25,
					color = { "Normal", "#1F2430" },
				},
			})
		end,
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
