return {
  "lewis6991/gitsigns.nvim", -- Async signs!
  event = "BufReadPre",
  config = function()
    local icons = require("util.icons")
    require("gitsigns").setup({
      signs = {
        add = { hl = "GitSignsAdd", text = icons.ui.BoldLineLeft, numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = {
          hl = "GitSignsChange",
          text = icons.ui.BoldLineLeft,
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn"
        },
        delete = {
          hl = "GitSignsDelete",
          text = icons.ui.Triangle,
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn"
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = icons.ui.Triangle,
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn"
        },
        changedelete = {
          hl = "GitSignsChange",
          text = icons.ui.BoldLineLeft,
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn"
        },
      },
    })
  end
}
