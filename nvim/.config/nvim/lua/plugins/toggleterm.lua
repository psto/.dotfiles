local M = {
  "akinsho/nvim-toggleterm.lua",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup {
      size = 20,
      open_mapping = [[<m-0>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    }

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new {
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "none",
        width = 100000,
        height = 100000,
      },
      count = 99,
    }

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    local xplr = Terminal:new {
      cmd = "xplr",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "none",
        width = 100000,
        height = 100000,
      },
      count = 99,
    }

    function _XPLR_TOGGLE()
      xplr:toggle()
    end

    local node = Terminal:new({ cmd = "node", hidden = true })

    function _NODE_TOGGLE()
      node:toggle()
    end

    local htop = Terminal:new({ cmd = "htop", hidden = true })

    function _HTOP_TOGGLE()
      htop:toggle()
    end
  end,
}

return M
