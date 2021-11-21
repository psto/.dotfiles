local key_map = vim.api.nvim_set_keymap

-- run the last command
key_map("n", "<leader><leader>c", ":<up>", { noremap = false })

-- Remove whitespace
key_map("n", "<leader>w", [[:%s/\s\+$//<CR>]], { noremap = false })

-- -- Move around splits with <c-hjkl>
-- key_map("n", "<c-j>", "<c-w>j", { noremap = false })
-- key_map("n", "<c-k>", "<c-w>k", { noremap = false })
-- key_map("n", "<c-h>", "<c-w>h", { noremap = false })
-- key_map("n", "<c-l>", "<c-w>l", { noremap = false })

-- move selected line up or down
key_map("v", "J", ":m '>+1<CR>gv=gv", { noremap = false })
key_map("v", "K", ":m '<-2<CR>gv=gv", { noremap = false })

-- unmap F1 help
key_map("n", "<F1>", "<nop>", { noremap = false })
key_map("i", "<F1>", "<nop>", { noremap = false })

-- " press <ctr> + s to save document
key_map("n", "<c-s>", ":w<CR>", { noremap = false })
key_map("i", "<c-s>", "<Esc>:w<CR>a", { noremap = false })
key_map("v", "<c-s>", "<Esc>:w<CR>", { noremap = false })

-- " clear last search highlighting
key_map("n", "<esc>", ":noh<return>", { noremap = false })

-- Reselect visual selection after indenting
key_map("v", "<", "<gv", { noremap = true, silent = true })
key_map("v", ">", ">gv", { noremap = true, silent = true })

-- " spell check with <F4> and <F5>
key_map("n", "<F4>", ":setlocal spell! spelllang=en_gb<CR>", { noremap = false })
key_map("n", "<F5>", ":setlocal spell spelllang=pl<CR>", { noremap = false })

-- " zoom a vim pane, <C-,>= to re-balance
-- nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
-- nnoremap <leader>= :wincmd =<cr>

-- " execute lua file in vim
-- nnoremap <leader>l :!lua %<CR>

-- " netrw-toggle.vim shortcut
key_map("n", "<c-n>", ":call ToggleNetrw()<CR>", { noremap = true, silent = true })

