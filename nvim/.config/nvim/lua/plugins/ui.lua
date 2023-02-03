return {

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "tokyonight",
          component_separators = "",
          section_separators = "",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy" } },
        },
      }
    end,
  },
  {
    "mrshmllow/document-color.nvim", -- Pretty colors for css, tailwindcss
    event = "BufReadPre",
    config = function()
      require("document-color").setup({
        mode = "background", -- "background" | "foreground" | "single"
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons", -- pretty icons
    event = "VeryLazy",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },
  { "p00f/nvim-ts-rainbow", event = "BufReadPost" }, -- Highlights
}
