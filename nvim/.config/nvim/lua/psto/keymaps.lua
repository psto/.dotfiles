-- TODO: rewrite using the new vim.keymap api https://github.com/neovim/neovim/commit/6d41f65aa45f10a93ad476db01413abaac21f27d
local key_map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Set leader key to space
vim.g.mapleader = " "

-- Run the last command
key_map("n", "<leader><leader>c", ":<up>", { noremap = false })

-- Remove whitespace
key_map("n", "<leader>w", [[:%s/\s\+$//<CR>]], { noremap = false })

-- -- Move around splits with <c-hjkl>
-- key_map("n", "<c-j>", "<c-w>j", { noremap = false })
-- key_map("n", "<c-k>", "<c-w>k", { noremap = false })
-- key_map("n", "<c-h>", "<c-w>h", { noremap = false })
-- key_map("n", "<c-l>", "<c-w>l", { noremap = false })

-- Resize with arrows
key_map("n", "<C-Up>", ":resize +2<CR>", opts)
key_map("n", "<C-Down>", ":resize -2<CR>", opts)
key_map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
key_map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
key_map("n", "<S-l>", ":bnext<CR>", opts)
key_map("n", "<S-h>", ":bprevious<CR>", opts)
-- Close current buffer
key_map("n", "<C-w>", ":bw<CR>", opts)

-- clear last search highlighting
key_map("n", "<esc>", ":noh<return>", { noremap = false })

-- spell check with <F4> and <F5>
key_map("n", "<F4>", ":setlocal spell! spelllang=en_gb<CR>", { noremap = false })
key_map("n", "<F5>", ":setlocal spell spelllang=pl<CR>", { noremap = false })

-- Unmap F1 help
key_map("n", "<F1>", "<nop>", { noremap = false })
key_map("i", "<F1>", "<nop>", { noremap = false })

-- Press <ctr> + s to save document
key_map("n", "<c-s>", ":w<CR>", { noremap = false })

-- Move selected line up or down
key_map("v", "J", ":m '>+1<CR>gv=gv", { noremap = false })
key_map("v", "K", ":m '<-2<CR>gv=gv", { noremap = false })

-- Don't yank on visual paste
key_map("v", "<leader>p", "\"_dP", { noremap = true, silent = true })

-- Don't yank on delete char
key_map("n", "x", '"_x', { noremap = true, silent = true })
key_map("n", "X", '"_X', { noremap = true, silent = true })
key_map("v", "x", '"_x', { noremap = true, silent = true })
key_map("v", "X", '"_X', { noremap = true, silent = true })

-- Reselect visual selection after indenting
key_map("v", "<", "<gv", opts)
key_map("v", ">", ">gv", opts)

key_map("n", "<M-j>", ":cnext<CR>zz", opts)
key_map("n", "<M-k>", ":cprev<CR>zz", opts)

-- Diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
key_map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
key_map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
key_map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
key_map("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- ToggleTerm
key_map("n", "<leader>t", "<cmd>:ToggleTerm<CR>", opts)

-- Lazygit
key_map("n", "<leader>l", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })

-- REST client
key_map("n", "<leader>r", "<Plug>RestNvim", opts)

-- nvim-ufo
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
