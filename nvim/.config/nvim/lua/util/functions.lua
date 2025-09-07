local M = {}

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
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

function M.diffview_toggle(cmd)
  if next(require("diffview.lib").views) == nil then
    vim.cmd(cmd)
  else
    vim.cmd("DiffviewClose")
  end
end

function M.toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

function M.get_url_title()
  -- grap url from cliboard
  local url = vim.fn.getreg "+"
  local is_url = url:match('[a-z]*://[^ >,;]*')
  if not is_url then
    -- vim.api.nvim_put({ url }, "l", true, true)
    vim.api.nvim_feedkeys('p', 'n', true)
    return
  end

  -- use curl to fetch url
  local handle = io.popen("curl -s " .. url)
  if not handle then return end
  local result = handle:read("*a")
  handle:close()

  -- grab text between <title></title> tag from result BUT don't include the <title></title>
  local title = result:match("<title>(.-)</title>")

  local markdown_url = " [" .. title .. "](" .. url .. ")"

  -- write markdown_url into current file
  vim.api.nvim_put({ markdown_url }, "", true, true)
end

return M
