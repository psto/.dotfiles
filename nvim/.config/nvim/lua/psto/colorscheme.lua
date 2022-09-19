if os.getenv('theme') == 'light' then
  vim.o.background = 'light'
end

-- Available colorschemes:
local colorscheme = "tokyonight"
-- local colorscheme = "dracula"
-- local colorscheme = "duskfox"
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

