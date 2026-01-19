return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- Function to define LSP mappings
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- Find references for the word under your cursor.
        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Disable vue_ls formatting
        -- if client and client.name == 'vue_ls' then
        --   client.server_capabilities.documentFormattingProvider = false
        -- end

        -- Highlight references of the word under the cursor
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          -- When cursor moves, the highlights will be cleared
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- Toggle inlay hints if the language server supports them
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>gd', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, 'Toggle Inlay Hints')
        end
      end,
    })

    -- Diagnostic Config
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Check and suggest installation for missing LSP servers
    local function check_lsp_binary(server)
      local binaries = {
        clangd = 'clangd',
        pyright = 'pyright-langserver',
        vue_ls = 'vue-language-server',
        jdtls = 'jdtls',
        rust_analyzer = 'rust-analyzer',
        ts_ls = 'typescript-language-server',
        lua_ls = 'lua-language-server',
        bashls = 'bash-language-server',
        phpactor = 'phpactor',
        -- tailwindcss = 'tailwindcss-language-server',
        nil_ls = 'nil',
        qml = 'qmlls6',
      }

      local pkg_map = {
        clangd = 'clang',
        pyright = 'pyright',
        vue_ls = 'vue-language-server',
        jdtls = 'jdtls',
        rust_analyzer = 'rust-analyzer',
        ts_ls = 'typescript-language-server',
        lua_ls = 'lua-language-server',
        bashls = 'bash-language-server',
        phpactor = 'phpactor',
        -- tailwindcss = 'tailwindcss-language-server',
        nil_ls = 'nil-git',
        qml = 'qmlls6',
      }

      local bin = binaries[server]
      if not bin then
        return true
      end -- skip unknown
      return vim.fn.executable(bin) == 1, pkg_map[server]
    end

    local function suggest_install_missing(missing)
      if #missing == 0 then
        return
      end
      local pkgs = table.concat(missing, ' ')
      local choice = vim.fn.input(string.format('Missing LSP servers detected. Install all with paru? (%s) [y/N]: ', pkgs))
      if choice:lower() == 'y' then
        vim.cmd('split | term paru -S ' .. pkgs)
      else
        vim.notify('Skipped installation for: ' .. pkgs, vim.log.levels.INFO)
      end
    end

    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.

    local uv = vim.uv or vim.loop
    local fs = require 'lspconfig.util'
    local servers = {
      -- See `:help lspconfig-all` for a list of all the pre-configured LSPs

      -- clangd
      clangd = {},

      -- pyright-langserver
      pyright = {},

      -- typescript-language-server
      -- explicitly disable old tsserver / ts_ls so they don't conflict with vtsls
      tsserver = { enabled = false },
      ts_ls = { enabled = false },

      -- vtsls (TypeScript + Vue integration)
      vtsls = {
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'vue',
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = { enableServerSideFuzzyMatch = true },
            },
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = '/usr/lib/node_modules/@vue/language-server',
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = { completeFunctionCalls = true },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      },

      -- vue-language-server (depends on vtsls)
      vue_ls = {
        init_options = {
          typescript = {
            -- must point to vtsls or tsserver client ID
            tsdk = '/usr/lib/node_modules/typescript/lib',
            -- tell volar which LSP to use for TS features
            -- vtsls registers under this name
            lspClient = 'vtsls',
          },
        },
        filetypes = { 'vue' },
      },

      -- jdtls
      jdtls = {
        capabilities = capabilities,
        handlers = { ['$/progress'] = function() end },
        settings = {
          java = {
            configuration = {
              runtimes = {
                { name = 'JavaSE-21', path = '/usr/lib/jvm/java-21-openjdk', default = true },
              },
            },
            import = { gradle = { enabled = true, wrapper = true } },
          },
        },
        cmd = { 'jdtls' },
      },

      -- rust-analyzer
      rust_analyzer = {
        enabled = true,
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              features = 'all',
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enabled = true,
              ignored = {
                leptos_macro = {
                  -- "component",
                  'server',
                },
              },
            },
            -- checkOnSave = {
            --   command = 'clippy',
            -- },
          },
        },
      },

      -- lua-language-server
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },

      -- bash-language-server
      bashls = {},

      -- phpactor
      phpactor = {},

      -- tailwindcss-language-server
      -- tailwindcss = {},

      -- nil + nixfmt
      nil_ls = {},

      roslyn_ls = {
        cmd = {
          'dotnet',
          '/home/strawberries/Microsoft/roslyn_ls/content/LanguageServer/linux-x64/Microsoft.CodeAnalysis.LanguageServer.dll',
          '--logLevel', -- this property is required by the server
          'Information',
          '--extensionLogDirectory', -- this property is required by the server
          '/tmp/roslyn_ls/logs',
          '--stdio',
        },
      },

      qmlls = {
        cmd = { 'qmlls6' },
        filetypes = { 'qml' },
      },

      ruby_lsp = {
        filetypes = { 'ruby' },
        cmd = { 'ruby-lsp' }, -- or { "bundle", "exec", "ruby-lsp" },
        root_markers = { 'Gemfile', '.git' },
        init_options = {
          formatter = 'standard',
          linters = { 'standard' },
          -- addonSettings = {
          --   ['Ruby LSP Rails'] = {
          --     enablePendingMigrationsPrompt = false,
          --   },
          -- },
        },
      },
    }

    -- collect missing LSPs first
    local missing_pkgs = {}
    for name, _ in pairs(servers) do
      local ok, pkg = check_lsp_binary(name)
      if not ok and pkg then
        table.insert(missing_pkgs, pkg)
      end
    end

    suggest_install_missing(missing_pkgs)

    for name, opts in pairs(servers) do
      -- merge user opts with capabilities
      opts = vim.tbl_deep_extend('force', { capabilities = capabilities }, opts or {})

      -- special handling for vtsls: ensure vue filetype, copy TS settings to JS,
      if name == 'vtsls' then
        -- make sure vue is present
        opts.filetypes = opts.filetypes or {}
        local has_vue = false
        for _, ft in ipairs(opts.filetypes) do
          if ft == 'vue' then
            has_vue = true
            break
          end
        end
        if not has_vue then
          table.insert(opts.filetypes, 'vue')
        end

        -- copy typescript settings into javascript so JS gets same behavior
        if opts.settings and opts.settings.typescript then
          opts.settings.javascript = vim.tbl_deep_extend('force', {}, opts.settings.typescript, opts.settings.javascript or {})
        end
      end

      vim.lsp.config(name, opts)
      vim.lsp.enable { name }
    end
  end,
}
