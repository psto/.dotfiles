return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    'j-hui/fidget.nvim', -- LSP status updates
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    "lukas-reineke/lsp-format.nvim",
    "SmiteshP/nvim-navic",
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

    local n_status_ok, navic = pcall(require, "nvim-navic")
    if not n_status_ok then return end

    -- start mason
    mason.setup()

    -- lsp_lines
    lsp_lines.setup()

    -- Turn on lsp status information
    fidget.setup()

    -- async formatter
    lsp_format.setup()

    -- navic for winbar
    navic.setup({ separator = "  " })

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- formatting with lsp-format
      require("lsp-format").on_attach(client)

      -- attach navic to lsp only if client has symbol provider capability
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      -- Mappings.
      local keymap = vim.keymap.set
      local bufopts = { noremap = true, silent = true, buffer = bufnr }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
      keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
      keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
      keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
      keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
      keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
      keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)
      keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
      keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", bufopts)
      keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", bufopts)
      keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", bufopts)
      -- keymap("n", "<space>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
      -- keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
      -- keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", bufopts)

      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      local config = {
        virtual_text = false, -- disable annoying inline diagnostics
        virtual_lines = false, -- { only_current_line = true }, -- lsp_lines for current line
        signs = {
          active = signs, -- show signs
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

      -- rounded borders for float windows
      -- TODO: solve conflict with noice plugin
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      -- colors with document-color.nvim
      if client.server_capabilities.colorProvider then
        -- Attach document colour support
        require("document-color").buf_attach(bufnr)
      end

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- Enable (broadcasting) snippet capability for completion
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.colorProvider = { dynamicRegistration = true }

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = { "ansiblels", "astro", "bashls", "gopls", "marksman", "prismals", "svelte", "solidity_ls" }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        },
      })
    end

    -- tsserver config
    -- nvim_lsp.tsserver.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    --   settings = {
    --     completions = {
    --       completeFunctionCalls = true
    --     }
    --   },
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    -- })

    -- volar config
    nvim_lsp.volar.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      init_options = {
        typescript = {
          tsdk = "/home/piotr/.local/share/npm/lib/node_modules/typescript/lib",
        },
      },
      flags = {
        debounce_text_changes = 150,
      },
    })

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
      single_file_support = false,
    })

    -- eslint config
    nvim_lsp.eslint.setup({
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

    -- sumneko config
    -- install on arch:$ sudo pacman -S lua-language-server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    require('lspconfig').sumneko_lua.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT', -- Tell the language server which version of Lua you're using
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
      on_attach = on_attach,
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
