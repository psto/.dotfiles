-- local g = vim.g
-- Colorscheme options
-- g.tokyonight_transparent = true
-- g.tokyonight_style = "night"
-- g.tokyonight_dark_float = false
-- g.tokyonight_transparent_sidebar = true
-- g.nightflyTransparent = 1

-- Available colorschemes:
-- local colorscheme = "tokyonight"
-- local colorscheme = "dracula"
-- local colorscheme = "duskfox"
-- local colorscheme = "onedark"
-- local colorscheme = "nightfly"
local colorscheme = "kanagawa"

require'kanagawa'.setup({
  overrides  = {
    NormalFloat = { bg = "NONE" }, -- set floating window background to transparent
  }
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
