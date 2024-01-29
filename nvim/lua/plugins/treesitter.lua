return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_,opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
      },
      indent = {
        enable = false
      }
    }
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        rainbow = {
          enable = true,
          -- Which query to use for finding delimiters
          query = {
            'rainbow-parens',
            html = "rainbow-tags"
          },
          -- Highlight the entire buffer all at once
          strategy = require('ts-rainbow').strategy.global,
        }
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    opts = {
     enable = true, 
     max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
     min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
     line_numbers = true,
     multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
     trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
     mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
     -- Separator between context and content. Should be a single character string, like '-'.
     -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
     separator = "_",
     zindex = 20, -- The Z-index of the context window
     on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
   },
   config = true

  },
  {
    'andymass/vim-matchup',
    opts = {
      matchup = {
        enable = true
      }
    },
    config = function(_,opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = true
  }
}
