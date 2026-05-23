return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1a1b26',
				base01 = '#1a1b26',
				base02 = '#ccced1',
				base03 = '#ccced1',
				base04 = '#424345',
				base05 = '#f9fbff',
				base06 = '#f9fbff',
				base07 = '#f9fbff',
				base08 = '#ff7da1',
				base09 = '#ff7da1',
				base0A = '#719eff',
				base0B = '#71ff86',
				base0C = '#bed3ff',
				base0D = '#719eff',
				base0E = '#d5e2ff',
				base0F = '#d5e2ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#ccced1',
				fg = '#f9fbff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#719eff',
				fg = '#1a1b26',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#ccced1' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#bed3ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#d5e2ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#719eff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#719eff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#bed3ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#71ff86',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#424345' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#424345' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#ccced1',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
