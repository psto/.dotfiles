return {
  {
    "echasnovski/mini.indentscope",
    event = "BufReadPost",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      scope = {
        enabled = false
      },
      indent = {
        char = "│",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local icons = require("util.icons")

      require("lualine").setup({
        options = {
          theme = "tokyonight",
          component_separators = "",
          section_separators = "",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy" } },
          symbols = {
            modified = icons.git.LineModified .. " ",
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = {
            {
              'vim.fn["codeium#GetStatusString"]()', -- codeium status
              fmt = function(str)
                return icons.misc.MagicWand .. " " .. str:lower():match("^%s*(.-)%s*$")
              end
            },
            'encoding', 'fileformat', 'filetype'
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
      })
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons", -- pretty icons
    event = "VeryLazy",
    config = function()
      local devicons = require("nvim-web-devicons")
      devicons.setup({ default = true })
      devicons.set_icon({
        astro = {
          icon = "",
          color = "#ff7e33",
          name = "astro",
        }
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>hn",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      background_colour = "#1a1b26",
      stages = "fade",
      timeout = 3000,
      top_down = false,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        -- signature = { enabled = false },
        -- hover = { enabled = false }
      },
      presets = {
        bottom_search = false,
        command_palette = false, -- center or top
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true,              -- enables the Noice messages UI
        view = "mini",               -- default view for messages
        view_error = "mini",         -- view for errors
        view_warn = "mini",          -- view for warnings
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      commands = {
        -- :Noice last
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp",      kind = "message" },
            },
          },
          filter_opts = { count = 1 },
        },
      },
      routes = {
        { -- hide written messages
          view = "mini",
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
        },
        { -- show @recording messages
          view = "mini",
          filter = { event = "msg_showmode" },
        },
        { -- hide empty messages when <S-K> hover
          view = "notify",
          filter = { find = "No information available" },
          opts = { skip = true },
        },
      }
    },
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      {
        "<c-f>",
        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" }
      },
      {
        "<c-b>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" }
      },
    },
  },
  {
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git", -- rainbow parentheses
    event = "BufReadPost"
  },
  {
    url = "https://github.com/lewis6991/satellite.nvim",
    event = "BufReadPost",
    opts = {
      current_only = false,
      winblend = 50,
      zindex = 40,
      excluded_filetypes = {},
      width = 2,
      handlers = {
        cursor = {
          enable = true,
          symbols = { '⎺', '⎻', '⎼', '⎽' } -- Supports any number of symbols
        },
        search = { enable = true },
        diagnostic = {
          enable = true,
          signs = { '-', '=', '≡' },
          min_severity = vim.diagnostic.severity.HINT,
        },
        gitsigns = {
          enable = true,
          signs = { -- can only be a single character (multibyte is okay)
            add = "│",
            change = "│",
            delete = "-",
          },
        },
        marks = {
          enable = true,
          show_builtins = false, -- shows the builtin marks like [ ] < >
          key = 'm'
        },
        quickfix = { signs = { '-', '=', '≡' } }
      },
    }
  },
}
