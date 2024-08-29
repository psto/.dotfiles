return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "debugloop/telescope-undo.nvim",
    "ThePrimeagen/harpoon",
    "ThePrimeagen/git-worktree.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local icons = require("util.icons")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { ".lock" },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " " .. icons.ui.Search .. " ",
        color_devicons = true,
        winblend = 20,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
          i = {
            ["<Esc>"] = actions.close,
            ["<C-c>"] = actions.close,
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
          "--glob=!.git/",
        },
      },
      pickers = {
        buffers = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
        },
        find_files = {
          theme = "dropdown",
          hidden = true,
          previewer = false,
        },
        git_branches = {
          theme = "dropdown",
          previewer = false,
        },
        git_status = {
          previewer = true,
        },
        grep_string = {
          theme = "dropdown",
        },
        live_grep = {
          theme = "dropdown",
        },
        lsp_references = {
          theme = "dropdown",
          initial_mode = "normal",
        },
        lsp_definitions = {
          theme = "dropdown",
          initial_mode = "normal",
        },
        lsp_declarations = {
          theme = "dropdown",
          initial_mode = "normal",
        },
        lsp_implementations = {
          theme = "dropdown",
          initial_mode = "normal",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          theme = "dropdown",
          previewer = false,
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        },
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        }
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")
    telescope.load_extension("undo")
    telescope.load_extension("harpoon")
    telescope.load_extension("git_worktree")
  end,
  search_dotfiles = function()
    require("telescope.builtin").find_files({
      prompt_title = "< DOTFILES >",
      cwd = vim.env.DOTFILES,
      hidden = true,
    })
  end,
  search_nvim_dotfiles = function()
    require("telescope.builtin").find_files({
      prompt_title = "< nvim DOTFILES >",
      cwd = "~/.dotfiles/nvim/.config/nvim",
      hidden = true,
    })
  end
}
