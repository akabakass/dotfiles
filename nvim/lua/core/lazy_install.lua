return require("lazy").setup({



  -- Completiion stuff
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "lukas-reineke/cmp-rg",
  --     {
  --      "dmitmel/cmp-vim-lsp",
  --      require = "prabirshrestha/vim-lsp"
  --    }
  "hrsh7th/cmp-nvim-lua",

  -- Snippet completion
  {
    'L3MON4D3/LuaSnip',
    version = "v2;*",
    build = "make install_jsregexp"
  },
  'saadparwaiz1/cmp_luasnip',
  'doxnit/cmp-luasnip-choice',

  -- LSP management
  {
  },

  -- debugging tool
  'mfussenegger/nvim-dap',
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap"
    }
  },
  'tlaiheHamsta/nvim-dap-virtual-text',
  'nvim-telescope/telescope-dap.nvim',
  'LiadOz/nvim-dap-repl-highlights',
  'rcarriga/cmp-dap',
  {
  "mxsdev/nvim-dap-vscode-js",
  requires = {"mfussenegger/nvim-dap"}
  },
  {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },


  -- swow next available keys to  for keymaps
  -- TODO: check mappings

  -- autopairs
  {
    "altermo/ultimate-autopair.nvim",
    event = {
      "InsertEnter",
      "CmdlineEnter"
    },
    config = function()
      require('ultimate-autopair').setup({})
    end
  },

  -- comment
  "numToStr/Comment.nvim",


  -- git management

  -- when your sick of it
  'Eandrju/cellular-automaton.nvim',

  -- screensaver
  "tamton-aquib/zone.nvim",

},
{
  lazy = true
})
