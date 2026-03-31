return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require("base16-colorscheme").setup({

				base00 = "#16161e",
				base01 = "#1a1b26",
				base02 = "#2f3549",
				base03 = "#9498a0",
				base0B = "#fff871",
				base04 = "#3d3e41",
				base05 = "#f6faff",
				base06 = "#f6faff",
				base07 = "#f6faff",
				base08 = "#ff326d",
				base09 = "#ff326d",
				base0A = "#1d7cff",
				base0C = "#98c3ff",
				base0D = "#1d7cff",
				base0E = "#bdd9ff",
				base0F = "#bdd9ff",
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(
					current_file_path,
					{},
					vim.schedule_wrap(function()
						local new_spec = dofile(current_file_path)
						if new_spec and new_spec[1] and new_spec[1].config then
							new_spec[1].config()
							print("Theme reload")
						end
					end)
				)
			end
		end,
	},
}
