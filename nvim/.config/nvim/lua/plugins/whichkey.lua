return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,       -- shows a list of your marks on ' and `
      registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true,       -- default bindings on <c-w>
        nav = true,           -- misc bindings to work with windows
        z = true,             -- bindings for folds, spelling and others prefixed with z
        g = true,             -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      ["<leader>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded",       -- none, single, double, shadow
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },                                             -- min and max height of the columns
      width = { min = 20, max = 50 },                                             -- min and max width of the columns
      spacing = 3,                                                                -- spacing between columns
      align = "center",                                                           -- align columns left, center or right
    },
    ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = false,                                                            -- show help message on the command line when the popup is visible
    -- triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    local l_opts = {
      mode = "n",     -- NORMAL mode
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }
    local m_opts = {
      mode = "n",
      prefix = "m",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local m_mappings = {
      m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon Mark" },
      ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
      [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
      s = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
      [";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
    }

    local mappings = {
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Action" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>:bw<CR>", "Close Buffer" },
      e = { "<cmd>Neotree toggle<CR>", "File Explorer" },
      j = { "<cmd>Telescope jumplist<cr>", "Jumplist" },
      M = { "<cmd>Mason<CR>", "Mason" },
      t = { "<cmd>ToggleTerm <CR>", "File Explorer" },
      q = { '<cmd>lua require("util/functions").smart_quit()<CR>', "Quit" },
      d = {
        name = "Debug",
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        d = { "<cmd>:g/console.lo/dd<cr>", "Remove console logs" },
        g = { "<cmd>lua require('zippy').insert_print()<CR>", "Console log" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
        O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
        l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
        u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
      },
      f = {
        name = "Find",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
        c = { "<cmd>Telescope git_bcommits<cr>", "Buffer's commits" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        d = { "<cmd>Telescope diagnostics<cr>", "Find Errors" },
        f = { "<cmd>Telescope find_files<cr>", "Find Files" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        H = { "<cmd>Telescope highlights<cr>", "Highlights" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        o = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        p = { "<cmd>Telescope file_browser path=%:p:h<CR>", "File Browser" },
        q = { "<cmd>Telescope quickfix <CR>", "Quickfix List" },
        Q = { "<cmd>Telescope quickfixhistory <CR>", "Quickfix History" },
        r = { "<cmd>Telescope resume<cr>", "Last Search" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        s = { "<cmd>Telescope spell_suggest theme=get_cursor<CR>", "Spelling" },
        t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        u = { "<cmd>Telescope undo<cr>", "Undo" },
        w = { "<cmd>Telescope grep_string<cr>", "Find Word" },
      },
      g = {
        name = "Git",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = { '<cmd>lua require("util/functions").diffview_toggle()<CR>', "DiffViewToggle" },
        D = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
        e = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Git Blame" },
        g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        l = { "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>", "Git Blame" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
        q = { "<cmd>Gitsigns setqflist<cr>", "Hunk List" },
        r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
        R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
        s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
        t = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Create worktree" },
        u = {
          "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
          "Undo Stage Hunk",
        },
        w = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "List worktrees" },
      },
      l = {
        name = "LSP",
        d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
        h = { "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>", "Hint" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        j = {
          "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
          "Next Diagnostic",
        },
        k = {
          "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
          "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Diagnostic quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          "Workspace Symbols",
        },
        u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
        v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
        w = {
          "<cmd>Telescope lsp_workspace_diagnostics<cr>",
          "Workspace Diagnostics",
        },
        x = { "<cmd>TroubleToggle quickfix<cr>", "Trouble quickfix" },
        z = { "<cmd>TroubleToggle loclist<cr>", "Trouble loclist" },
      },
      L = {
        name = "Lazy",
        c = { "<cmd>Lazy clean<cr>", "Clean" },
        h = { "<cmd>Lazy check<cr>", "Check" },
        i = { "<cmd>Lazy install<cr>", "Install" },
        l = { "<cmd>Lazy<cr>", "Lazy" },
        o = { "<cmd>Lazy log<cr>", "Log" },
        s = { "<cmd>Lazy sync<cr>", "Sync" },
        p = { "<cmd>Lazy profile<cr>", "Profile" },
        u = { "<cmd>Lazy update<cr>", "Update" },
      },
      r = {
        name = "Replace",
        r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
        f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
      },
      s = {
        name = "System",
        c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
        d = {
          name = "dotiles",
          n = { '<cmd>lua require("plugins.telescope").search_nvim_dotfiles()<CR>', "Nvim dotfiels" },
          s = { '<cmd>lua require("plugins.telescope").search_dotfiles()<CR>', "System dotfiels" },
        },
        h = { "<cmd>lua _HTOP_TOGGLE()<CR>", "htop" },
        n = {
          name = "Noice",
          a = { "<cmd>lua require('noice').cmd('all')<CR>", "Noice All" },
          h = { "<cmd>lua require('noice').cmd('history')<CR>", "Noice History" },
          l = { "<cmd>lua require('noice').cmd('last')<CR>", "Noice Last Message" },
        },
        r = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node REPL" },
        s = { "<cmd>lua require('util.assistance').so_input()<CR>", "  StackOverflow" },
        w = { "<cmd>:%s/\\s\\+$//<CR>", "Trim Whitespaces" },
        x = { "<cmd>lua _XPLR_TOGGLE()<CR>", "File Xplr" },
      }
    }

    wk.setup(opts)
    wk.register(mappings, l_opts)
    wk.register(m_mappings, m_opts)
  end,
}
