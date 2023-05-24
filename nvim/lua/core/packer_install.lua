local packer_status, packer = pcall(require, "packer")
if not packer_status then
  return
end

return packer.startup({
  function(use)
    -- packer handle itself
    use ('wbthomason/packer.nvim')

    --install pretty icons
    use ('nvim-tree/nvim-web-devicons')

    -- improve syntax highlighting
    use {
      "nvim-treesitter/nvim-treesitter",
      {
        run = ":TSUpdate"
      }
    }
    use {
      "HiPhish/nvim-ts-rainbow2",
      requires = {
        "nvim-treesitter/nvim-treesitter"
      }
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
    
    -- Completiion stuff
    -- this need double check
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
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
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "j-hui/fidget.nvim",
        opts = {} -- same as calling resuire('fidget').setup({})
      }
    }
    use 'WhoIsSethDaniel/mason-tool-installer.nvim'

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

