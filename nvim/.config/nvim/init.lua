require("config/options")
require("config/autocommands")
require("config/keymaps")
require("config/lazy")
require('vim._extui').enable({
  enable = true,                 -- Whether to enable or disable the UI.
  msg = {                        -- Options related to the message module.
    ---@type 'cmd'|'msg' Where to place regular messages, either in the
    ---cmdline or in a separate ephemeral message window.
    target = 'cmd',
    timeout = 4000, -- Time a message is visible in the message window.
  },
})
