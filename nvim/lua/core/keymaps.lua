local key = vim.keymap.set

local opts = function(desc)
  return {noremap = true, silent = true, desc = desc}
end

-- try space as leader key
key("", "<Space>", "<Nop>", opts("set space as leader"))
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ###############
-- # NORMAL MODE #
-- ###############

-- allow to navigate better between windows
key('n', "<C-h>", "<C-w>h", opts("move to lefter window"))
key('n', "<C-j>", "<C-w>j", opts("move to lower window"))
key('n', "<C-k>", "<C-w>k", opts("move to upper window"))
key('n', "<C-l>", "<C-w>l", opts("move to righter window"))

--easy resizing with arrow keys
key('n', "<C-Up>", ":resize -2<CR>", opts())
key('n', "<C-Down>", ":resize +2<CR>", opts())
key('n', "<C-Left>", ":vertical resize -2<CR>", opts())
key('n', "<C-Right>", ":vertical resize +2<CR>", opts())


-- ###############
-- # VISUAL MODE #
-- ###############

-- stay in indent mode
key('v', '<', '<gv', opts())
key('v', '>', '>gv', opts())

-- #############
-- # nvim-tree #
-- #############

key("n", "<C-a>", ":NvimTreeToggle<CR>", opts())
key("n", "<C-f>", ":NvimTreeFindFileToggle<CR>", opts())

-- #############
-- # telescope #
-- #############

local telescope_b_status, telescope_b = pcall(require, "telescope.builtin")
if telescope_b_status then
  key("n", "<leader>ff", telescope_b.find_files, opts("[F]ind [F]iles"))
  key("n", "<leader>gl", telescope_b.live_grep, opts("[G]rep [L]ive"))
  key("n", "<leader>gs", telescope_b.grep_string, opts("[G]rep [S]tring"))
  key("n", "<leader>fh", telescope_b.help_tags, opts("[F]ind [H]elp"))
  key("n", "<leader>fb", telescope_b.buffers, opts("[F]ind [B]uffer"))
end

-- ############
-- # cellular #
-- ############

key("n", "<leader>fuc", "<cmd>CellularAutomaton make_it_rain<CR>", opts('make it rain'))
key("n", "<leader>fuk", "<cmd>CellularAutomaton game_of_life<CR>", opts('game of life'))

-- ############
-- # fugitive #
-- ############

key('n', '<leader>gg', '<cmd>Git<CR>', opts('[G]it [S]tatus'))
