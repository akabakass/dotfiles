return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
      ensure_installed = {
        "pyright",
        "lemminx",
        "ts_ls",
        "html",
        "intelephense"
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      'neovim/nvim-lspconfig'
    },
    config = function()
      local mason_lsp = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      mason_lsp.setup({
        auto_install = true,
        ensure_installed = {
          "pyright",
          "lemminx",
          "ts_ls",
          "intelephense"
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          ["pyright"] = function()
            lspconfig.pyright.setup({
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                  }
                }
              }
            })
          end,

          ["intelephense"] = function()
            lspconfig.intelephense.setup({
              capabilities = capabilities,
              settings = {
                intelephense = {
                  licenceKey = "",
                  diagnostics = { undefinedConstants = false },
                  files = { maxSize = 50000000 }
                }
              }
            })
          end,

          ["lemminx"] = function()
            lspconfig.lemminx.setup({
              capabilities = capabilities,
              filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
              settings = {
                xml = {
                  server = {
                    workDir = vim.fn.expand("~/.cache/lemminx")
                  },
                  validation = {
                    noGrammar = "ignore",
                  }
                }
              }
            })
          end,
        }
      })
      if not configs.odoo_lsp then
        configs.odoo_lsp = {
          default_config = {
            name = "odoo_lsp",
            cmd = {
              "odoo-lsp"
            },
            filetypes = {
              "python",
              "javascript",
              "xml"
            },
            root_dir = lspconfig.util.root_pattern(".odoo_lsp.json", ".git")
          }
        }
      end

      lspconfig.odoo_lsp.setup({
        capabilities = capabilities,
        on_init = function(client)
          -- Force la synchronisation complète AVANT l'initialisation du changetracking
          -- 1 correspond à TextDocumentSyncKind.Full
          if type(client.server_capabilities.textDocumentSync) == "table" then
            client.server_capabilities.textDocumentSync.change = 1
          else
            client.server_capabilities.textDocumentSync = 1
          end
          if client.server_capabilities.completionProvider then
            local triggers = client.server_capabilities.completionProvider.triggerCharacters or {}
            table.insert(triggers, ".")
            client.server_capabilities.completionProvider.triggerCharacters = triggers
          end
        end,
      })
    end
  }
}
