return {
	-- Diagnostics
	{
		"folke/trouble.nvim",
		event = "BufReadPre",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
	},

	-- REST client
	-- {
	-- 	"ray-x/web-tools.nvim",
	-- 	event = "BufReadPre",
	-- 	config = function()
	-- 		require("web-tools").setup({
	-- 			keymaps = {
	-- 				rename = nil, -- by default use same setup of lspconfig
	-- 				-- repeat_rename = '.',  -- . to repeat
	-- 			},
	-- 			hurl = { -- hurl default
	-- 				show_headers = false, -- do not show http headers
	-- 				floating = false, -- use floating windows (need guihua.lua)
	-- 				formatters = { -- format the result by filetype
	-- 					json = { "jq" },
	-- 					html = { "prettier", "--parser", "html" },
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	--   "ethancarlsson/nvim-hurl.nvim",
	--   event = "BufReadPre",
	-- },
	{
		"m4xshen/hardtime.nvim",
		event = "BufReadPre",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disable_mouse = false,
			disabled_keys = {
				["<Up>"] = {},
				["<Down>"] = {},
				["<Left>"] = {},
				["<Right>"] = {},
			},
			restricted_keys = {
				["h"] = {},
				["j"] = {},
				["k"] = {},
				["l"] = {},
			},
		},
	},
}
