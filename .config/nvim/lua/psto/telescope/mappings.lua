local key_map = vim.api.nvim_set_keymap

key_map("n", "<c-p>", [[<CMD>Telescope find_files<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>fg", [[<CMD>Telescope live_grep<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>fb", [[<CMD>Telescope buffers<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>fh", [[<CMD>Telescope help_tags<CR>]], { noremap = true, silent = true })

key_map("n", "<leader>vrc", [[:lua require('psto.telescope.setup').search_dotfiles()<CR>]], { noremap = true, silent = true })
