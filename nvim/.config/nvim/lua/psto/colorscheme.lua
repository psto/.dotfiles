if os.getenv('theme') == 'light' then
  vim.o.background = 'light'
end

-- Available colorschemes:
local colorscheme = "tokyonight"

local tokyonight_status_ok, tokyonight = pcall(require, "tokyonight")
if tokyonight_status_ok then
  tokyonight.setup({
    style = "night", -- three styles: `storm`, a darker variant `night` and `day`
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
  })
end

local status_ok, _ = pcall(require, colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.cmd("colorscheme " .. colorscheme)
