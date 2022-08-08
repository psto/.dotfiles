local key_map = vim.api.nvim_set_keymap

key_map("n", "<leader>ss", [[<cmd>lua require('spectre').open()<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>sw", [[<cmd>lua require('spectre').open_visual({select_word=true})<CR>]], { noremap = true, silent = true })

key_map("n", "<leader>sv", [[<esc>:lua require('spectre').open_visual()<CR>]], { noremap = true, silent = true })
