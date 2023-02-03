return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring", -- jsx/tsx comment support
    event = "BufReadPre",
  },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
}
