local packer_status, packer = pcall(require, "packer")
if not packer_status then
  return
end

return packer.startup({
  function(use)
    -- packer handle itself
    use ('wbthomason/packer.nvim')

    -- jump back to last place when opening a file
    use 'ethanholz/nvim-lastplace'

    --install pretty icons
    use ('nvim-tree/nvim-web-devicons')

    -- improve syntax highlighting, and navigation
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
              local ts_update = require('nvim-treesitter.install').update({with_sync = true})
              ts_update()
            end
    }
    use {
      "HiPhish/nvim-ts-rainbow2",
      requires = {
        "nvim-treesitter/nvim-treesitter"
      }
    }
    use {
      "nvim-treesitter/nvim-treesitter-context",
      requires = {
        "nvim-treesitter/nvim-treesitter"
      }
    }
    use {
      "theHamsta/nvim-treesitter-pairs",
      requires = {
        "nvim-treesitter/nvim-treesitter"
      }
    }
    use 'nvim-treesitter/playground'
    use 'mfussenegger/nvim-treehopper'
    use {
      'andymass/vim-matchup',
      setup = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end
    }
    -- color scheme
    use ("EdenEast/nightfox.nvim")

    -- startup screen
    use ({
      'glepnir/dashboard-nvim',
      requires = {'nvim-tree/nvim-web-devicons'}
    })

    -- show indentation guides
    use ("lukas-reineke/indent-blankline.nvim")

    -- preview colors (ex: #aeaeff)
    use ('norcalli/nvim-colorizer.lua')

    
    -- a nice filetree explorer
    use ('nvim-tree/nvim-tree.lua')

    -- a project manager
    use "ahmedkhalf/project.nvim"

    -- fuzzy finder
    use ({
      'nvim-telescope/telescope.nvim',
      tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
    })
    -- add packer functionality to telescope
    use "nvim-telescope/telescope-packer.nvim"
    -- add git repo list to telescope
    use "cljoly/telescope-repo.nvim"
    -- fuzzy search undofile
    use {
      "debugloop/telescope-undo.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
      }
    }
    -- add undoHistory management
    use "mbbill/undotree"
    
    -- Completiion stuff
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "lukas-reineke/cmp-rg"
--    use {
--      "dmitmel/cmp-vim-lsp",
--      require = "prabirshrestha/vim-lsp"
--    }
    use "hrsh7th/cmp-nvim-lua"

    -- Snippet completion
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'doxnit/cmp-luasnip-choice'

    -- LSP management
    use {
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate"
      },
      "williamboman/mason-lspconfig.nvim",
      {
        "j-hui/fidget.nvim",
        opts = {} -- same as calling resuire('fidget').setup({})
      }
    }
    use 'WhoIsSethDaniel/mason-tool-installer.nvim'

    -- debugging tool
    use 'mfussenegger/nvim-dap'
    use { 
      "rcarriga/nvim-dap-ui",
      requires = {
        "mfussenegger/nvim-dap"
      } 
    }
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'LiadOz/nvim-dap-repl-highlights'
    use 'rcarriga/cmp-dap'

    -- lsp kind for neovim config
    use "folke/neodev.nvim"
    
    -- swow next available keys to use for keymaps
    -- TODO: check mappings
    use "folke/which-key.nvim"

    -- autopairs
    use "windwp/nvim-autopairs"

    -- comment
    use "numToStr/Comment.nvim"
    use {
      "JoosepAlviste/nvim-ts-context-commentstring",
      requires = {
        "nvim-treesitter/nvim-treesitter"
      }
    }


    -- git management
    use "lewis6991/gitsigns.nvim"
    use "tpope/vim-fugitive"

    -- when your sick of it
    use 'Eandrju/cellular-automaton.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if Packer_bootstrap then
      require('packer').sync()
    end
  end,
  -- show install window floating
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({border = "rounded"})
      end
    }
  }
})

