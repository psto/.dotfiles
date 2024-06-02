local M = {}

-- function M.jump_over_closing_pair()
--   local line = vim.api.nvim_get_current_line()
--   local col = vim.api.nvim_win_get_cursor(0)[2]
--   local char_to_right = string.sub(line, col + 1, col + 1)
--   local chars_to_jump = { '"', ")", "]", "}", "'", ">" }

--   if vim.tbl_contains(chars_to_jump, char_to_right) then
--     vim.cmd("stopinsert")
--     vim.api.nvim_feedkeys("la", "n", true)
--   else
--     vim.cmd("stopinsert")
--   end
-- end

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd "q!"
      end
    end)
  else
    vim.cmd "q!"
  end
end

function M.diffview_toggle()
  local lib = require("diffview.lib")
  local view = lib.get_current_view()
  if view then
    -- Current tabpage is a Diffview; close it
    vim.cmd.DiffviewClose()
  else
    -- No open Diffview exists: open a new one
    vim.cmd.DiffviewOpen()
  end
end

return M
