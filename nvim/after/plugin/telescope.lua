local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
  return
end

local actions_status, actions = pcall(require, "telescope.actions")
if not actions_status then
  return
end

require("telescope").load_extension "projects"

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


key = vim.keymap.set

local opts = function(desc)
  return {noremap = true, silent = true, desc = desc}
end

key("n", "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({hidden = true}))<CR>", opts("[F]ind [P]roject"))

