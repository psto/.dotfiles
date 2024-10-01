return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    popup_border_style = "rounded",
    default_component_configs = {
      git_status = {
        symbols = {
          added = "",    -- or "✚"; redundant info if you use git_status_colors on the name
          modified = "", -- or ""; redundant info if you use git_status_colors on the name
        },
      },
    },
    window = {
      position = "right",
      width = 30,
      mappings = {
        ["l"] = "open",
      },
    },
  },
}
