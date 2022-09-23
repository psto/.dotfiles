local autocmd = vim.api.nvim_create_autocmd

-- Use 'q' to quit from common plugins
autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- Set wrap and spell in markdown and gitcommit
autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fixes Autocomment
autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Highlight Yanked Text
autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- automatically rebalance windows on vim resize
-- autocmd({ "VimResized" }, {
--   callback = function()
--     vim.cmd "wincmd ="
--   end,
-- })

-- terminal transparency can be set also with picom or hyprland
-- autocmd({ "ColorScheme" }, {
--   callback = function()
--     vim.cmd "hi Normal ctermbg=none guibg=none cterm=none"
--   end,
-- })
