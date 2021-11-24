-- set leader key to space
vim.g.mapleader = " "

require('psto/options')
require('psto/plugins')
require('psto/keymaps')

-- Neovim builtin LSP configuration
require("psto/lsp")

-- telescope setup
require('psto/telescope.setup')
require('psto/telescope.mappings')

-- trouble mappings
require('psto/trouble')

