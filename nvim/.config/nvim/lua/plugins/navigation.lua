return {
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    config = function()
      require("neoscroll").setup({})
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    opts = {
      disable_when_zoomed = true
    },
    config = function(_, opts)
      local tmux_navigation = require("nvim-tmux-navigation")
      tmux_navigation.setup(opts)

      vim.keymap.set('n', "<C-h>", tmux_navigation.NvimTmuxNavigateLeft)
      vim.keymap.set('n', "<C-j>", tmux_navigation.NvimTmuxNavigateDown)
      vim.keymap.set('n', "<C-k>", tmux_navigation.NvimTmuxNavigateUp)
      vim.keymap.set('n', "<C-l>", tmux_navigation.NvimTmuxNavigateRight)
      vim.keymap.set('n', "<C-\\>", tmux_navigation.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', "<C-Space>", tmux_navigation.NvimTmuxNavigateNext)
    end,
  },
}
