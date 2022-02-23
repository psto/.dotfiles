local key_map = vim.api.nvim_set_keymap

key_map("n", "<c-p>", [[<CMD>Telescope find_files<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>fg", [[<CMD>Telescope live_grep<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>fb", [[<CMD>Telescope buffers<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>fh", [[<CMD>Telescope help_tags<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>fr", [[<CMD>Telescope oldfiles<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>fc", [[<CMD>Telescope current_buffer_fuzzy_find<CR>]], { noremap = true, silent = true })
-- search in dotfiles
key_map("n", "<leader>vrc", [[:lua require('psto.telescope.setup').search_dotfiles()<CR>]], { noremap = true, silent = true })
-- live grep
key_map("n", "<leader>fl", [[:lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>]], { noremap = true, silent = true })
-- find word under cursor
key_map("n", "<leader>fw", "<CMD>Telescope grep_string<CR>", { noremap = true })
-- find file under cursor
key_map("n", "<leader>ff", "yiw<CMD>Telescope find_files<CR><C-r>+", { noremap = true })
