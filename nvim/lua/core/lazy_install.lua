local lazy_status, lazy = pcall(require, "lazy")
if not lazy_status then
  return
end

return lazy.setup({

  -- jump back to last place when opening a file
  'ethanholz/nvim-lastplace',

  --install pretty icons
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true
  },

  -- improve syntax highlighting, and navigation
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    build = ":TSUpdate"
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "theHamsta/nvim-treesitter-pairs",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  'nvim-treesitter/playground',
  'mfussenegger/nvim-treehopper',
  {
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
  -- color scheme
  "EdenEast/nightfox.nvim",

  -- startup screen
  {
    'glepnir/dashboard-nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'}
  },

  -- show indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl"
  },

  -- preview colors (ex: #aeaeff)
  'norcalli/nvim-colorizer.lua',


  -- a nice filetree explorer
  'nvim-tree/nvim-tree.lua',

  -- a project manager
  "ahmedkhalf/project.nvim",

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  -- add packer functionality to telescope
  "tsakirist/telescope-lazy.nvim",
  -- add git repo list to telescope
  "cljoly/telescope-repo.nvim",
  -- fuzzy search undofile
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    opts = {

    }
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim"
    }
  },
  -- add undoHistory management
  "mbbill/undotree",
  -- Completiion stuff
  'neovim/nvim-lspconfig',
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
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'doxnit/cmp-luasnip-choice',

  -- LSP management
  {
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate"
    },
    "williamboman/mason-lspconfig.nvim",
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
      opts = {} -- same as calling resuire('fidget').setup({})
    }
  },
  'WhoIsSethDaniel/mason-tool-installer.nvim',

  -- debugging tool
  'mfussenegger/nvim-dap',
  { 
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap"
    } 
  },
  'theHamsta/nvim-dap-virtual-text',
  'nvim-telescope/telescope-dap.nvim',
  'LiadOz/nvim-dap-repl-highlights',
  'rcarriga/cmp-dap',

  -- lsp kind for neovim config
  "folke/neodev.nvim",

  -- swow next available keys to  for keymaps
  -- TODO: check mappings
  "folke/which-key.nvim",

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
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },


  -- git management
  "lewis6991/gitsigns.nvim",
  "tpope/vim-fugitive",

  -- when your sick of it
  'Eandrju/cellular-automaton.nvim'

},
{
  lazy = true
})

