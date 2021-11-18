-- set leader key to comma
vim.g.mapleader = ","

-- lua require'lspconfig'.tsserver.setup{}
require('psto.options')
require('psto.plugins')
require('psto.keymaps')

-- telescope setup
require('psto.telescope.setup')
require('psto.telescope.mappings')

require('neoscroll').setup()
require('nvim-treesitter.configs').setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
require('trouble').setup {}
require('nvim-web-devicons').setup { default = true }
require('lualine').setup{ options = { theme = 'nightfox', section_separators = '', component_separators = ''}}
