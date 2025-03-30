--AI completion
return {
  {
    "Exafunction/codeium.vim",
    event = "BufReadPre",
    config = function()
      local keymap = vim.keymap.set

      keymap('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      keymap('i', '<c-.>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      keymap('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
      keymap('i', '<c-;>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    end
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require("chatgpt").setup({})
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },
}
