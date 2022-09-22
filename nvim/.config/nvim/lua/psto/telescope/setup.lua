local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", ".lock" },
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = "   ",
    color_devicons = true,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<Esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<c-d>"] = require("telescope.actions").delete_buffer,
      },
      n = {
        ["dd"] = require("telescope.actions").delete_buffer,
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
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      hidden = true,
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "insert",
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
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
      mappings = {
        ["i"] = {
          -- Ctrl+Enter creates new file
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
})

-- require('telescope').load_extension('fzy_native')
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< DOTFILES >",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end

return M
