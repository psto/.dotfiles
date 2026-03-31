return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- dap
		"mfussenegger/nvim-dap",
		{ "jay-babu/mason-nvim-dap.nvim" },

		-- Faster LuaLS setup for Neovim
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ "nvim-dap-ui" },
				},
			},
		},

		-- Useful status updates for LSP.
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0,
						align = "bottom",
					},
				},
			},
		},

		-- autocomplete
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("jam-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- Jump to the declaration of the word under your cursor.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Find references for the word under your cursor.
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				map("gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "[G]oto [T]ype Definition")

				-- Show diagnostics for the word under your cursor.
				map("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "[G]oto [L]ine Diagnostics")

				-- Show signature help for the word under your cursor.
				map("gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "[G]oto [S]ignature Help")

				map("lv", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "[G]oto [S]ignature Help")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				-- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				local function toggle_virtual_lines()
					local new_config = not vim.diagnostic.config().virtual_lines
					vim.diagnostic.config({ virtual_lines = new_config })
				end

				-- Toggle virtual lines
				map("<leader>vd", toggle_virtual_lines, "Toggle diagnostic virtual_lines")

				local function toggle_virtual_text()
					local new_config = not vim.diagnostic.config().virtual_text
					vim.diagnostic.config({ virtual_text = new_config })
				end

				-- Toggle virtual text
				map("<leader>vt", toggle_virtual_text, "Toggle diagnostic virtual_text")

				-- Rename the variable under your cursor.
				map("<leader>lr", vim.lsp.buf.rename, "[R]e[n]ame")

				-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
				---@param client vim.lsp.Client
				---@param method vim.lsp.protocol.Method
				---@param bufnr? integer some lsp support methods only in specific files
				---@return boolean
				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client_supports_method(
						client,
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
			end,
		})

		local lspIcons = require("util.icons")
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = { text = { ERROR = "", WARN = "", INFO = "", HINT = "" } },
			virtual_text = {
				virt_text_pos = "eol",
				prefix = "",
				format = function(diagnostic)
					local icons = {
						[vim.diagnostic.severity.ERROR] = lspIcons.diagnostics.Error,
						[vim.diagnostic.severity.WARN] = lspIcons.diagnostics.BoldWarning,
						[vim.diagnostic.severity.INFO] = lspIcons.diagnostics.BoldInformation,
						[vim.diagnostic.severity.HINT] = lspIcons.diagnostics.BoldQuestion,
					}
					return string.format("%s %s", icons[diagnostic.severity], diagnostic.message)
				end,
			},
		})

		local status_ok, lspconfig = pcall(require, "lspconfig")
		if not status_ok then
			return
		end

		local servers = {
			astro = {},
			bashls = {},
			cssls = {
				filetypes = { "css", "scss", "less", "vue" },
			},
			denols = {
				workspace_required = true,
				root_markers = { "deno.json", "deno.jsonc" },
			},
			eslint = {
				settings = { workingDirectories = { mode = "auto" } },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},

				workspace_required = true,
				root_markers = { ".eslintrc.json", ".eslintrc", ".eslintrc.js" },
			},
			gopls = {},
			harper_ls = {
				filetypes = { "markdown" },
				settings = {
					["harper-ls"] = {
						-- userDictPath = "",
						-- fileDictPath = "",
						linters = {
							-- SpellCheck = true,
							ToDoHyphen = false,
						},
						codeActions = {
							ForceStable = false,
						},
						markdown = {
							IgnoreLinkTitle = false,
						},
						diagnosticSeverity = "hint",
						isolateEnglish = true,
					},
				},
			},
			html = {},
			jsonls = {
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
								description = "ESLint config",
								fileMatch = { ".eslintrc.json", ".eslintrc" },
								url = "http://json.schemastore.org/eslintrc",
							},
							{
								description = "Prettier config",
								fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
								url = "http://json.schemastore.org/prettierrc",
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
			},
			lua_ls = {
				-- cmd = { ... },
				-- filetypes = { ... },
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
			marksman = {},
			pylsp = {},
			ruff = {
				trace = "messages",
				init_options = {
					settings = {
						logLevel = "debug",
					},
				},
			},
			rust_analyzer = {},
			ts_ls = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				workspace_required = true,
				root_markers = { "package.json" },
			},
			tailwindcss = {
				filetypes = {
					"astro",
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
			},
			vtsls = {
				workspace_required = true,
				root_markers = { "package.json" },
			},
			vue_ls = {},
		}

		---@type MasonLspconfigSettings
		---@diagnostic disable-next-line: missing-fields
		require("mason-lspconfig").setup({
			automatic_enable = vim.tbl_keys(servers or {}),
		})

		-- Ensure the servers and tools above are installed
		--
		-- To check the current status of installed tools and/or manually install
		-- other tools, you can run
		--    :Mason
		--
		-- You can press `g?` for help in this menu.
		--
		-- `mason` had to be setup earlier: to configure its options see the
		-- `dependencies` table for `nvim-lspconfig` above.
		--
		-- You can add other tools here that you want Mason to install
		-- for you, so that they are available from within Neovim.
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			"typescript-language-server",
			"js-debug-adapter",
			"gopls",
			"delve",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Installed LSPs are configured and enabled automatically with mason-lspconfig
		-- The loop below is for overriding the default configuration of LSPs with the ones in the servers table
		for server_name, config in pairs(servers) do
			vim.lsp.config(server_name, config)
		end

		require("mason-nvim-dap").setup()
	end,
}
