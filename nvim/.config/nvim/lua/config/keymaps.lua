local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key to space
-- vim.g.mapleader = " " -- must be set before lazy.nvim

-- Run the last command
keymap("n", "<leader><leader>c", ":<up>", { noremap = false })

-- Remove whitespace
keymap("n", "<leader>w", [[:%s/\s\+$//<CR>]], { noremap = false })

-- -- Move around splits with <c-hjkl>
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-k>", "<c-w>k", opts)
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-l>", "<c-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- clear last search highlighting
keymap("n", "<esc>", ":noh<return>", { noremap = false })

-- spell check with <F4> and <F5>
keymap("n", "<F4>", ":setlocal spell! spelllang=en_gb<CR>", { noremap = false })
keymap("n", "<F5>", ":setlocal spell spelllang=pl<CR>", { noremap = false })

-- Unmap F1 help
keymap("n", "<F1>", "<nop>", { noremap = false })
keymap("i", "<F1>", "<nop>", { noremap = false })

-- ctrl+s to save document
keymap("n", "<c-s>", ":w<CR>", { noremap = false })

-- Move selected line up or down
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = false, silent = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = false, silent = true })

-- Select entire line without new line character
keymap("n", "<S-b>", "0vg_", opts)

-- Don't yank on paste
keymap("x", "P", "\"_dP", opts)

-- Don't yank on delete char
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)
keymap("v", "x", '"_x', opts)
keymap("v", "X", '"_X', opts)

-- Reselect visual selection after indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- auto indent when insert on an empty line
keymap("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

-- enter "one-eyed fighting kirby" regex in command mode
keymap("c", "<F2>", "\\(.*\\)", opts)

-- harpoon
keymap(
  "n",
  "<m-;>",
  "<cmd>lua require('telescope').extensions.harpoon.marks(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Harpoon'})<cr>"
  ,
  opts
)

-- telescope
keymap("n", "<c-p>", [[<CMD>Telescope find_files<CR>]], opts)

-- show buffers
keymap(
  "n",
  "<s-tab>",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>"
  ,
  opts
)

-- add to jumplist
keymap("n", "<m-m>", "<cmd>normal m'<cr>", opts)
