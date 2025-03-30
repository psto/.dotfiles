-- taken from https://github.com/adityastomar67/NvStar
local TERMINAL = require("toggleterm.terminal").Terminal
local M        = {}

-- For creating new Terminal Instance
function M.open_term(cmd, opts)
  opts           = opts or {}
  opts.size      = opts.size or vim.o.columns * 0.5
  opts.direction = opts.direction or "vertical"
  opts.on_open   = opts.on_open
  opts.on_exit   = opts.on_exit or nil

  local new_term = TERMINAL:new {
    cmd             = cmd,
    dir             = "git_dir",
    auto_scroll     = false,
    close_on_exit   = false,
    start_in_insert = false,
    on_open         = opts.on_open,
    on_exit         = opts.on_exit
  }
  new_term:open(opts.size, opts.direction)
end

return M
