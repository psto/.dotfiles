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
          lualine_b = { 'branch' },
          lualine_c = {
            'filename',
            {
              'diff',
              colored = true,
              diff_color = {
                added    = { fg = '#9ece6a' },
                modified = { fg = '#e0af68' },
                removed  = { fg = '#f7768e' },
              },
              symbols = { added = icons.git.LineAdded .. ' ', modified = icons.git.LineModified .. ' ', removed = icons.git.LineRemoved .. ' ' },
              source = nil,
            },
          },
          lualine_x = {
            'diagnostics',
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
        extensions = { "lazy", "mason", "neo-tree", "nvim-dap-ui", "trouble", "toggleterm" },
      })
    end
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {}
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
