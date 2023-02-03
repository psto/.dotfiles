--AI completion
return {
  { "Exafunction/codeium.vim", event = "BufReadPre" },
  { "aduros/ai.vim", event = "BufReadPre" },
  {
    "jackMort/ChatGPT.nvim",
    event = "BufReadPre",
    config = function()
      require("chatgpt").setup({})
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
}
