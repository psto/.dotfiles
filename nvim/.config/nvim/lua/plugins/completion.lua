return {
  {
    "nvim-mini/mini.pairs",
    version = false,
    event = "BufReadPre",
    opts = {}
  },
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    opts = {}
  },
  {
    "windwp/nvim-ts-autotag", -- auto close and rename html tag
    event = "BufReadPre",
    opts = {}
  },
  {
    "L3MON4D3/LuaSnip", -- snippets
    event = "InsertEnter",
    dependencies = {
      "psto/friendly-snippets",
      config = function()
        -- specify the path so that friendly-snippets are not duplicated
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip").filetype_extend("typescript", { "javascript" })
        require("luasnip").filetype_extend("typescriptreact", { "javascriptreact" })
      end,
    },
  },
  -- auto completion
  {
    'saghen/blink.cmp',
    lazy = "VeryLazy",
    dependencies = {
      "psto/friendly-snippets",
      -- 'saadparwaiz1/cmp_luasnip',
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'super-tab', -- 'super-tab' for mappings similar to vscode
        ['<C-y>'] = { 'select_and_accept' },
        ["<C-j>"] = { "select_prev", "fallback" },
        ["<C-k>"] = { "select_next", "fallback" },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        -- 'full' will fuzzy match on the text before _and_ after the cursor
        keyword = { range = 'full' },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = false },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      snippets = {
        preset = "luasnip",
      },
      signature = { enabled = true }, -- Experimental signature help support
    },
    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }
  },
}
