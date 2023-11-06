return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",    -- three styles: `storm`, a darker variant `night` and `day`
      transparent = true, -- enable transparency

      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.orange, bold = true }
        hl.LineNr = { fg = c.orange, bold = true }
        hl.LineNrAbove = { fg = c.fg_gutter }
        hl.LineNrBelow = { fg = c.fg_gutter }
        -- borderless Telescope config
        hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
        hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopePromptNormal = { bg = c.bg_dark }
        hl.TelescopePromptBorder = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopePromptTitle = { bg = c.bg_dark, fg = c.orange }
        hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd('colorscheme tokyonight')
    end,
  },
}
