vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>Trouble lsp_document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>tq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "tR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)
