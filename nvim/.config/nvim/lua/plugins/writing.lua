return {
  {
    "folke/twilight.nvim",
    event = "BufReadPre",
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#24283b" },
      }
    },
    config = function(_, opts)
      require("twilight").setup(opts)
    end,
  },
  { "folke/zen-mode.nvim", event = "BufReadPre" },
  {
    "zk-org/zk-nvim",
    event = "VeryLazy",
    config = function()
      require("zk").setup({
        -- See Setup section below
        picker = "telescope",
      })
    end
  },
}
