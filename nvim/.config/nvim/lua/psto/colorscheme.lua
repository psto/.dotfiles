local g = vim.g
-- Colorscheme options
-- g.tokyonight_transparent = true
-- g.tokyonight_style = "night"
-- g.tokyonight_dark_float = false
-- g.tokyonight_transparent_sidebar = true
g.tokyonight_colors = { bg_float = "#24283b" }
-- g.nightflyTransparent = 1

-- Available colorschemes:
local colorscheme = "tokyonight"
-- local colorscheme = "dracula"
-- local colorscheme = "duskfox"
-- local colorscheme = "onedark"
-- local colorscheme = "nightfly"
-- local colorscheme = "kanagawa"

-- TODO: fix must be before pcall, but will throw an error if colorscheme is not found
-- require'kanagawa'.setup({
--   overrides  = {
--     -- set floating window background to transparent
--     NormalFloat = { bg = "NONE" },
--     FloatBorder = { bg = "NONE" },
--   }
-- })

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

