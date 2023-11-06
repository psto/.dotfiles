return {
  -- Debugging
  { "PatschD/zippy.nvim", event = "BufReadPre" },

  -- Diagnostics
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    event = "BufReadPre",
  },

  -- DevDocs
  {
    "luckasRanarison/nvim-devdocs",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {}
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

  -- REST client
  { "NTBBloodbath/rest.nvim", dependencies = "nvim-lua/plenary.nvim", event = "BufReadPre" },

}
