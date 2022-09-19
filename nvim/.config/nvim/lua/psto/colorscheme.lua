if os.getenv('theme') == 'light' then
  vim.o.background = 'light'
end

-- Available colorschemes:
local colorscheme = "tokyonight"
-- local colorscheme = "dracula"
-- local colorscheme = "duskfox"
-- local colorscheme = "nightfly"
-- local colorscheme = "kanagawa"

local tokyonight_status_ok, tokyonight = pcall(require, "tokyonight")
if tokyonight_status_ok then
  tokyonight.setup({
    style = "storm", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    transparent = true, -- Enable this to disable setting the background color

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
  })
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
