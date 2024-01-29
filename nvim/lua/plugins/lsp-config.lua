return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded"
      }
    },
    config = true
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      'neovim/nvim-lspconfig'
    },
    config = function()
      local mason_lsp = require("mason-lspconfig")
      mason_lsp.setup({
        auto_install = true
      })
      mason_lsp.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup ({
            root_dir = function() return vim.loop.cwd() end
          })
        end
      }
    end
  },
  {
    "folke/neodev.nvim",
    config = true,
    opts = {
      library = { 
        plugins = { 
          "nvim-dap-ui" 
        }, 
        types = true 
      }
    }
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = true,
    opts = {
      auto_update = true,
      run_on_start = true
    }
  }
}
