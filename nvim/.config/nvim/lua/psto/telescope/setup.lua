local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".lock" },
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = "   ",
    color_devicons = true,
    winblend = 20,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<Esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<Tab>"] = actions.close,
        ["<S-Tab>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<c-d>"] = require("telescope.actions").delete_buffer,
      },
      n = {
        ["<Esc>"] = actions.close,
        ["q"] = actions.close,
        ["<Tab>"] = actions.close,
        ["<S-Tab>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["dd"] = require("telescope.actions").delete_buffer,
        ["?"] = actions.which_key,
      }
    },

    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--hidden", -- search in hidden files
      "--smart-case",
      "-u", -- thats the new thing
    },
  },
  pickers = {
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "insert",
    },
    find_files = {
      hidden = true,
      theme = "dropdown",
      previewer = false,
    },
    git_branches = {
      theme = "dropdown",
      previewer = false,
    },
  },
  extensions = {
    -- fzy_native = {
    --     override_generic_sorter = false,
    --     override_file_sorter = true,
    -- }
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    file_browser = {
      theme = "dropdown",
      previewer = false,
      mappings = {
        ["i"] = {
          -- Ctrl+Enter creates new file
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  },
})

-- require('telescope').load_extension('fzy_native')
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")

local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< DOTFILES >",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end

M.search_nvim_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< nvim DOTFILES >",
    cwd = "~/.dotfiles/nvim/.config/nvim",
    hidden = true,
  })
end

return M
