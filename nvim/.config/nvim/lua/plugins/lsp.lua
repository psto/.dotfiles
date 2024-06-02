return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    -- 'j-hui/fidget.nvim', -- LSP status updates
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = { winblend = 0 },
        },
      }
    },
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    "lukas-reineke/lsp-format.nvim",
  },
  opts = {
    inlay_hints = {
      enabled = true
    }
  },
  config = function()
    local status_ok, nvim_lsp = pcall(require, "lspconfig")
    if not status_ok then return end

    local l_status_ok, lsp_lines = pcall(require, "lsp_lines")
    if not l_status_ok then return end

    local f_status_ok, fidget = pcall(require, "fidget")
    if not f_status_ok then return end

    local lf_status_ok, lsp_format = pcall(require, "lsp-format")
    if not lf_status_ok then return end

    local m_status_ok, mason = pcall(require, "mason")
    if not m_status_ok then return end

    -- start mason
    mason.setup()

    -- lsp_lines
    lsp_lines.setup()

    -- Turn on lsp status information
    fidget.setup()

    -- async formatter
    lsp_format.setup()

    -- icons
    local icons = require("util.icons")

    local config = {
      virtual_text = false,  -- disable annoying inline diagnostics
      virtual_lines = false, -- { only_current_line = true }, -- lsp_lines for current line
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = icons.diagnostics.BoldWarning,
          [vim.diagnostic.severity.INFO] = icons.diagnostics.BoldInformation,
          [vim.diagnostic.severity.HINT] = icons.diagnostics.BoldQuestion,
        }
      },
      update_in_insert = false,
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

    -- Mappings.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local keymap = vim.keymap.set
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
        keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
        keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
        keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
        keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
        keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)
        keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
        keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", bufopts)
        keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", bufopts)
        keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", bufopts)
      end,
    })

    local on_attach = function(client)
      -- formatting with lsp-format
      require("lsp-format").on_attach(client)

      -- enable inlay hints
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable()
      end

      -- rounded borders for float windows
      -- TODO: solve conflict with noice plugin
      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --   border = "rounded",
      -- })
      -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      --   border = "rounded",
      -- })
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- Enable (broadcasting) snippet capability for completion
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = { "ansiblels", "bashls", "html", "gopls", "marksman", "prismals", "pylsp", "rnix", "svelte" }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        },
      })
    end

    nvim_lsp.astro.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        typescript = {
          tsdk = "/home/piotr/.local/share/npm/lib/node_modules/typescript/lib",
        },
      },
    })

    -- tsserver config
    nvim_lsp.tsserver.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = nvim_lsp.util.root_pattern("package.json"),
      single_file_support = false,
      init_options = {
        preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          importModuleSpecifierPreference = 'non-relative'
        },
      },
      settings = {
        completions = {
          completeFunctionCalls = true
        }
      },
      flags = {
        debounce_text_changes = 150,
      },
    })

    -- volar config
    -- nvim_lsp.volar.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    --   init_options = {
    --     typescript = {
    --       tsdk = "/home/piotr/.local/share/npm/lib/node_modules/typescript/lib",
    --     },
    --   },
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    -- })

    -- cssls config
    nvim_lsp.cssls.setup({
      capabilities = capabilities,
      filetypes = { "css", "scss", "less", "vue" },
    })

    -- deno config
    nvim_lsp.denols.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
    })

    -- eslint config
    nvim_lsp.eslint.setup({
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
      capabilities = capabilities,
      root_dir = nvim_lsp.util.root_pattern(".eslintrc.json", ".eslintrc", ".eslintrc.js"),
    })

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

    -- rust config
    nvim_lsp.rls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        rust = {
          unstable_features = true,
          build_on_save = false,
          all_features = true,
        },
      },
    })

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

    -- lua_ls config
    -- install on arch:$ sudo pacman -S lua-language-server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    require('lspconfig').lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          hint = {
            enable = true,
            setType = true,
          },
          runtime = {
            version = 'LuaJIT',  -- Tell the language server which version of Lua you're using
            path = runtime_path, -- Setup your lua path
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            -- library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = { enable = false }, -- Do not send telemetry
        },
      },
    }

    nvim_lsp.tailwindcss.setup({
      capabilities = capabilities,
      cmd = { "tailwindcss-language-server", "--stdio" },
      filetypes = {
        "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "edge", "eelixir", "ejs", "erb", "eruby",
        "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "jade", "leaf", "liquid", "mdx", "mustache", "njk",
        "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss",
        "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte",
        -- "markdown",
      },
      init_options = {
        userLanguages = {
          eelixir = "html-eex",
          eruby = "erb",
        },
      },
      on_new_config = function(new_config)
        if not new_config.settings then
          new_config.settings = {}
        end
        if not new_config.settings.editor then
          new_config.settings.editor = {}
        end
        if not new_config.settings.editor.tabSize then
          -- set tab size for hover
          new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
        end
      end,
      settings = {
        tailwindCSS = {
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
          experimental = {
            classRegex = {
              "tw`([^`]*)",
              'tw="([^"]*)',
              'tw={"([^"}]*)',
              "tw\\.\\w+`([^`]*)",
              "tw\\(.*?\\)`([^`]*)",
            },
          },
          validate = true,
        },
      },
    })
  end,
}
