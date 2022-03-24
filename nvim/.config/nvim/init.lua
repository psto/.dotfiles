require('impatient')        -- needs to be first
require('psto/options')
require('psto/plugins')
require('psto/keymaps')
require('psto/colorscheme')

-- Neovim builtin LSP configuration
require('psto/lsp')
-- cmp completion
require('psto/completion')

-- telescope setup
require('psto/telescope/setup')
require('psto/telescope/mappings')

-- treesitter
require('psto/treesitter')

-- trouble mappings
require('psto/trouble')

-- autopairs config
require('psto/autopairs')

-- nvim-tree
require('psto/nvim-tree')

-- bufferline
require('psto/bufferline')
