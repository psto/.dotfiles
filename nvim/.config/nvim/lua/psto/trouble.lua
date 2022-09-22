local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
  return
end

trouble.setup({})

local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>xx", [[<cmd>TroubleToggle<cr>]], { noremap = true, silent = true })
keymap("n", "<leader>xq", [[<cmd>TroubleToggle quickfix<cr>]], { noremap = true, silent = true })
keymap("n", "<leader>xl", [[<cmd>TroubleToggle loclist<cr>]], { noremap = true, silent = true })
