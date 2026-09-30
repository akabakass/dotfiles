return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      'neovim/nvim-lspconfig',
      'saghen/blink.cmp',
    },
    config = function()
      -- API 0.12 : vim.lsp.config() + vim.lsp.enable() remplacent les
      -- handlers de mason-lspconfig, retires en v2 (ils etaient ignores
      -- en silence, d'ou les settings pyright par defaut).

      -- '*' s'applique a TOUS les serveurs : les capabilities blink ne sont
      -- plus a repeter serveur par serveur.
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      vim.lsp.config('pyright', {
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

      vim.lsp.config('intelephense', {
        settings = {
          intelephense = {
            licenceKey = "",
            diagnostics = { undefinedConstants = false },
            files = { maxSize = 50000000 }
          }
        }
      })

      vim.lsp.config('lemminx', {
        filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
        settings = {
          xml = {
            server = { workDir = vim.fn.expand("~/.cache/lemminx") },
            validation = { noGrammar = "ignore" },
          }
        }
      })

      -- odoo-lsp n'est pas fourni par mason : on le declare comme les
      -- autres, root_markers remplace lspconfig.util.root_pattern.
      vim.lsp.config('odoo_lsp', {
        cmd = { "odoo-lsp" },
        filetypes = { "python", "javascript", "xml" },
        root_markers = { ".odoo_lsp.json", ".git" },
        on_init = function(client)
          -- odoo-lsp annonce un diagnosticProvider (diagnostics "pull").
          -- On retire la capability : nvim ne les demande plus du tout.
          -- Arbitrage : odoo-lsp fournit la completion champs/modeles/xmlid,
          -- pyright fournit les diagnostics Python. Ceux d'odoo-lsp sur les
          -- appels ORM sont approximatifs (ex. __count de _read_group).
          client.server_capabilities.diagnosticProvider = nil
          -- Force la synchronisation complete AVANT l'initialisation du
          -- changetracking. 1 = TextDocumentSyncKind.Full
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

      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "lemminx",
          "ts_ls",
          "intelephense",
        },
      })

      -- odoo-lsp n'est pas gere par mason : activation explicite.
      vim.lsp.enable('odoo_lsp')
    end
  }
}
