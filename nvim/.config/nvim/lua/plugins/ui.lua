return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "tokyonight",
          component_separators = "",
          section_separators = "",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy" } },
        },
      }
    end,
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
      require("nvim-web-devicons").setup({ default = true })
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

      cmdline = {
        enabled = true, -- enables the Noice cmdline UIview = "cmdline_popup", -- `cmdline` for a classic bottom cmdline or cmdline_popup for popup view
        view = "cmdline",
        opts = { buf_options = { filetype = "vim" } }, -- enable syntax highlighting in the cmdline
        icons = {
          ["/"] = { icon = " ", hl_group = "DiagnosticWarn" },
          ["?"] = { icon = " ", hl_group = "DiagnosticWarn" },
          [":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      routes = {
        { -- hide written messages
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        { -- show @recording messages
          view = "notify",
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
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true,
        desc = "Scroll forward", mode = { "i", "n", "s" } },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,
        expr = true, desc = "Scroll backward", mode = { "i", "n", "s" } },
    },
  },
  { "p00f/nvim-ts-rainbow", event = "BufReadPost" }, -- Highlights
}
