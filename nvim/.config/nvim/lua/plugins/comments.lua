return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring", -- jsx/tsx comment support
    event = "BufReadPre",
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end
  },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        ignore = '^$',
      }
    end,
  },
}
