return {
  "nvim-pack/nvim-spectre",
  dependencies = "nvim-lua/plenary.nvim",
  cmd = { "Spectre" },
  opts = {
    default = {
      find = {
        cmd = "rg",
        options = { "ignore-case" },
      },
      replace = {
        cmd = "sd",
      },
    },
  },
}
