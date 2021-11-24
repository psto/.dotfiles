local key_map = vim.api.nvim_set_keymap

key_map("n", "<leader>xx", [[<cmd>TroubleToggle<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>xq", [[<cmd>TroubleToggle quickfix<cr>]], { noremap = true, silent = true })

key_map("n", "<leader>xl", [[<cmd>TroubleToggle loclist<cr>]], { noremap = true, silent = true })
