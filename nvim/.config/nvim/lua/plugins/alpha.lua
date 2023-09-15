local M = {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local dashboard = require "alpha.themes.dashboard"
      dashboard.section.header.val = {
          [[              /\ \__          ]],
          [[ _____    ____\ \ ,_\   ___   ]],
          [[/\ '__`\ /',__\\ \ \/  / __`\ ]],
          [[\ \ \L\ \\__, `\\ \ \_/\ \L\ \]],
          [[ \ \ ,__//\____/ \ \__\ \____/]],
          [[  \ \ \/ \/___/   \/__/\/___/ ]],
          [[   \ \_\                      ]],
          [[    \/_/                      ]],
      }
      dashboard.section.buttons.val = {
          dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
          dashboard.button("SPC ff", " " .. " Find file", ":Telescope find_files <CR>"),
          dashboard.button("SPC fo", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
          dashboard.button("SPC ft", " " .. " Find text", ":Telescope live_grep <CR>"),
          dashboard.button("SPC vc", " " .. " Config", ":lua require('psto.telescope.setup').search_nvim_dotfiles()<CR>"),
          dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true
      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
          pattern = "LazyVimStarted",
          callback = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            pcall(vim.cmd.AlphaRedraw)
          end,
      })
    end,
}

return M
