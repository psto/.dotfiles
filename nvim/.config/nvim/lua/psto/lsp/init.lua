local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	local config = {
		virtual_text = false, -- disable annoying inline diagnostics
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	-- rounded borders for float windows
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	-- turn off document formatting to use null-ls by default
	local excludeFormatting = { "tsserver", "volar", "jsonls" }
	for _, server in ipairs(excludeFormatting) do
		if client.name == server then
			client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
			-- client.resolved_capabilities.text_document_publish_diagnostics = false
		end
	end
end

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "tsserver" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

-- jsonls config
nvim_lsp.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = {
				{
					description = "JSON schema for NPM package.json files",
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					description = "TypeScript compiler configuration file",
					fileMatch = { "tsconfig.json", "tsconfig.*.json" },
					url = "http://json.schemastore.org/tsconfig",
				},
				{
					description = "Lerna config",
					fileMatch = { "lerna.json" },
					url = "http://json.schemastore.org/lerna",
				},
				{
					description = "Babel configuration",
					fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
					url = "http://json.schemastore.org/lerna",
				},
				{
					description = "ESLint config",
					fileMatch = { ".eslintrc.json", ".eslintrc" },
					url = "http://json.schemastore.org/eslintrc",
				},
				{
					description = "Bucklescript config",
					fileMatch = { "bsconfig.json" },
					url = "https://bucklescript.github.io/bucklescript/docson/build-schema.json",
				},
				{
					description = "Prettier config",
					fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
					url = "http://json.schemastore.org/prettierrc",
				},
				{
					description = "Vercel Now config",
					fileMatch = { "now.json" },
					url = "http://json.schemastore.org/now",
				},
				{
					description = "Stylelint config",
					fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
					url = "http://json.schemastore.org/stylelintrc",
				},
                {
					description = "Docker Compose config",
					fileMatch = { "docker-compose.yml", "docker-compose.yaml" },
					url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
				},
			},
		},
	},
	flags = {
		debounce_text_changes = 150,
	},
})

-- volar config
nvim_lsp.volar.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	-- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
	filetypes = { "vue" },
	init_options = {
		typescript = {
			serverPath = "/usr/lib/node_modules/typescript/lib/tsserverlibrary.js",
		},
	},
	flags = {
		debounce_text_changes = 150,
	},
})

-- tailwindcss config
nvim_lsp.tailwindcss.setup({
	on_attach = on_attach,
	-- excluded: markdown
	filetypes = {
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"django-html",
		"edge",
		"eelixir",
		"ejs",
		"erb",
		"eruby",
		"gohtml",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
})

-- emmet config
local configs = require("lspconfig/configs")
if not nvim_lsp.emmet_ls then
	configs.emmet_ls = {
		default_config = {
			cmd = { "emmet-ls", "--stdio" },
			filetypes = { "html", "css", "vue" },
			root_dir = function()
				return vim.loop.cwd()
			end,
			settings = {},
		},
	}
end
nvim_lsp.emmet_ls.setup({ capabilities = capabilities, on_attach = on_attach })

-- deno config
nvim_lsp.denols.setup({
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json"),
})

-- astro config
nvim_lsp.astro.setup({})

-- prismals config
nvim_lsp.prismals.setup({})

-- graphql config
nvim_lsp.graphql.setup({
	on_attach = on_attach,
	capabilities = capabilities,
    cmd = { "graphql-lsp", "server", "-m", "stream" },
	-- filetypes = { "graphql", "typescriptreact", "javascriptreact", "vue" },
	flags = {
		debounce_text_changes = 150,
	},
})

-- go config
nvim_lsp.gopls.setup{}

-- solidity config
nvim_lsp.solidity_ls.setup{}

-- sumneko config
-- install on arch:$ sudo pacman -S lua-language-server
-- set the path to the sumneko installation
local sumneko_root_path = vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server"
-- set to:$ which lua-language-server
local sumneko_binary = "/usr/bin/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
