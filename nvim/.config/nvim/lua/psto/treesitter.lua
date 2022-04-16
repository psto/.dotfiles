local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end
-- a b c d e f g h i j k l m n o p q r s t u v w x y z
configs.setup({
	ensure_installed = {
		"astro",
		"bash",
		"c",
		"css",
		"dockerfile",
		"fish",
		"go",
		"graphql",
		"http",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"json5",
		"lua",
		"prisma",
		"pug",
		"python",
		"r",
		"ruby",
		"regex",
		"rust",
		"scss",
		"solidity",
		"svelte",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	}, -- list of languages or "all"
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	autopairs = {
		enable = true,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})
