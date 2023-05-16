local telescope_status, telescope = pcall(require, "telescope")
if not telescope then
  return
end

local builtin = require "telescope.builtin"
local actions = require "telescope.actions"

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
    sorting_strategy = "ascending"
  }
})
