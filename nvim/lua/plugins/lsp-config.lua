return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded"
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require("lspconfig")
      local blink_cmp_config = require("blink.cmp")
      local capabilities = blink_cmp_config.get_lsp_capabilities()

      local default_setup = lspconfig.util.default_config

      default_setup.capabilities = vim.tbl_deep_extend(
        "force",
        default_setup.capabilities or {},
        capabilities
      )
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
      mason_lsp.setup({
        auto_install = true,
        automatic_enable = true
      })
      vim.lsp.config["intelephense"] = {
        settings = {
          intelephense = {
            licenceKey = "",
            diagnostics = {
              undefinedConstants = false
            },
            files = {
              maxSize = 50000000
            }
          }
        }
      }
      --mason_lsp.setup_handlers {
      --  -- The first entry (without a key) will be the default handler
      --  -- and will be called for each installed server that doesn't have
      --  -- a dedicated handler.
      --  function (server_name) -- default handler (optional)
      --    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      --    local capabilities = require('blink.cmp').get_lsp_capabilities()
      --    local lsp_config = require("lspconfig")
      --    lsp_config[server_name].setup ({
      --      root_dir = function(file_name)
      --        return lsp_config.util.find_git_ancestor(file_name)
      --      end,
--    --        capabilities = capabilities
      --    })
      --  end,
      --  ['html'] = function()
      --    local lspconfig = require('lspconfig')
      --    lspconfig.html.setup({
      --      filetypes = {
      --        "php",
      --        "html"
      --      }
      --    })
      --  end
      --}
    end
  }
}
