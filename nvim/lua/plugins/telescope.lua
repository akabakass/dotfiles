return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function(_,opts)
      local actions = require("telescope.actions")
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-p>"] = actions.preview_scrolling_up,
              ["<C-n>"] = actions.preview_scrolling_down,
              ["<C-_>"] = actions.which_key
            }
          },
          layout_config = {
            prompt_position = "top"
          },
          sorting_strategy = "ascending",
          file_ignore_patterns = {
            ".git/"
          }
        },
      })
    end
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            use_delta = true,
            use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
            side_by_side = true,
            vim_diff_opts = {
              ctxlen = vim.o.scrolloff,
            },
            mappings = {
              i = {
                -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                -- you want to replicate these defaults and use the following actions. This means
                -- installing as a dependency of telescope in it's `requirements` and loading this
                -- extension from there instead of having the separate plugin definition as outlined
                -- above.
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-cr>"] = require("telescope-undo.actions").restore,
              }
            }
          }
        }
      })
      require("telescope").load_extension("undo")
    end
  },
  {
    "tsakirist/telescope-lazy.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("telescope").setup({
        extensions = {
          lazy = {
            -- Optional theme (the extension doesn't set a default theme)
            theme = "ivy",
            -- Whether or not to show the icon in the first column
            show_icon = true,
            -- Mappings for the actions
            mappings = {
              open_in_browser = "<C-o>",
              open_in_file_browser = "<M-b>",
              open_in_find_files = "<C-f>",
              open_in_live_grep = "<C-g>",
              open_plugins_picker = "<C-b>", -- Works only after having called first another action
              open_lazy_root_find_files = "<C-r>f",
              open_lazy_root_live_grep = "<C-r>g",
            },
            -- Other telescope configuration options
          },
        }
      })
      require("telescope").load_extension("lazy")
    end
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("telescope").setup()
      require("telescope").load_extension("projects")
    end
  },
  {
    "cljoly/telescope-repo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("telescope").setup()
      require("telescope").load_extension("repo")
    end
  }

}
