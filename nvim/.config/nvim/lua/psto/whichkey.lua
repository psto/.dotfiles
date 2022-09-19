local wk = require("which-key")

wk.register({
	f = {
		name = "find",
		-- c = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find word in file", noremap = true, silent = true},
		-- f = { "<cmd>Telescope find_files<cr>", "Find File",  noremap = true, silent = true},
		-- g = { "<cmd>Telescope live_grep<cr>", "Live Grep", noremap = true, silent = true},
		-- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = true, silent = true},
		-- w = { "<cmd>Telescope grep_string<cr>", "Find word under cursor", noremap = true, silent = true},
	},
	s = {
		name = "spectre",
		-- s = { "<cmd>lua require('spectre').open()<CR>", "Open Spectre", noremap = true, silent = true},
		-- w = { "<leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Current Word to replace", noremap = true, silent = true},
		-- v = { "<esc>:lua require('spectre').open_visual()<CR>", "Visual", noremap = true, silent = true},
	},
	w = {
		name = "trim whitespace",
	},
	x = {
		name = "trouble",
		-- x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble", noremap = true, silent = true},
		-- q = { "<cmd>TroubleToggle quickfix<cr>", "Errors to QuickFix", noremap = true, silent = true},
		-- l = { "<cmd>TroubleToggle loclist<cmd>", "Errors to loclist", noremap = true, silent = true},
	},
}, { prefix = "<leader>" })
