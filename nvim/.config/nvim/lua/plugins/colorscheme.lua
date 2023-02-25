return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- style = "night", -- three styles: `storm`, a darker variant `night` and `day`
      transparent = false, -- enable transparency

      on_highlights = function(hl, c)
        -- borderless Telescope config
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = c.bg_dark,
        }
        hl.TelescopePromptBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    },
    config = function(_, opts)
      local options = opts

      local hour = tonumber(os.date("%H"))
      if hour >= 8 and hour < 17 then
        options.style = "day"
      else
        options.style = "night"
      end

      require("tokyonight").setup(options)
      vim.cmd('colorscheme tokyonight')
    end,
  },
}
