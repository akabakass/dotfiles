local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
  return
end

local actions_status, actions = pcall(require, "telescope.actions")
if not actions_status then
  return
end

require("telescope").load_extension("projects")
require("telescope").load_extension("undo")

telescope.setup({
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
  extensions = {
    undo = {
      use_delta = true,
      use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      side_by_side = true,
      diff_context_lines = vim.o.scrolloff,
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


key = vim.keymap.set

local opts = function(desc)
  return {noremap = true, silent = true, desc = desc}
end

key("n", "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({hidden = true}))<CR>", opts("[F]ind [P]roject"))

