return {
  -- Debugging
  { "PatschD/zippy.nvim", event = "BufReadPre" },

  -- Diagnostics
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {}
  },

  {
  },

  -- LSP
  -- {
  --   "glepnir/lspsaga.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require("lspsaga").setup({})
  --   end,
  --   dependencies = { { "nvim-tree/nvim-web-devicons" } }
  -- },
}
