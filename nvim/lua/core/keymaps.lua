local key = vim.keymap.set

local opts = function(desc)
  return {noremap = true, silent = true, desc = desc}
end


-- key("", "<Space>", "<Nop>", opts("set space as leader"))
-- ###############
-- # NORMAL MODE #
-- ###############

key('n', '<C-n>', ":Dashboard<CR>", opts("launch dashboard"))

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

-- auto instert date and time
key('n', "<F9>", "i<C-R>=strftime('%Y-%m-%d %H:%M')<CR>")
key('i', "<F9>", "<C-R>=strftime('%Y-%m-%d %H:%M')<CR>")


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
  key("n", "<leader>fs", telescope_b.lsp_document_symbols, opts("[F]ind [S]ymbols"))
  key('n', "<leader>fr", telescope_b.lsp_references, opts("[F]ind [R]eferences"))
  key('n', "<leader>fd", telescope_b.lsp_definitions, opts("[F]ind [D]efinitions"))
  key("n", "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({hidden = true}))<CR>", opts("[F]ind [P]roject"))
end
key("n", "<leader>u", "<cmd>Telescope undo<CR>")
-- ############
-- # cellular #
-- ############

key("n", "<leader>fuc", "<cmd>CellularAutomaton make_it_rain<CR>", opts('make it rain'))
key("n", "<leader>fuk", "<cmd>CellularAutomaton game_of_life<CR>", opts('game of life'))

-- ############
-- # fugitive #
-- ############

key('n', '<leader>gg', '<cmd>Git<CR>', opts('[G]it [S]tatus'))

-- ##############
-- # treehopper #
-- ##############

key('o', 'm', ":<C-U>lua require('tsht').nodes()<CR>", {silent = true, desc = "treehopper"})
key('x', 'm', ":lua require('tsht').nodes()<CR>", opts("treehopper"))

-- #######
-- # DAP #
-- #######

key('n', '<F5>', function() require('dap').continue() end, opts("Start debbuging"))
key('n', '<F6>', function() 
  require('dap').close() 
  require('dapui').close()
end, opts("Stop debugging"))
key('n', '<F2>', function() require('dap').step_over() end, opts("Step over"))
key('n', '<F3>', function() require('dap').step_into() end, opts("Step into"))
key('n', '<F4>', function() require('dap').step_out() end, opts("Step out"))
key('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, opts("Toggle breakpoint"))
key('n', '<Leader>B', function() require('dap').toggle_breakpoint(vim.fn.input('Breakpoint condition : '), nil, nil) end, opts("Set conditional breakpoint"))
key('n', '<Leader>lb', function() require('dap').toggle_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, opts("Set log breakpoint"))
key('n', '<Leader>dr', function() require('dap').repl.open() end, opts("open repl"))
key('n', '<Leader>dl', function() require('dap').run_last() end, opts("run last"))
key({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, opts("show hover info"))
key({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, opts("show preview info"))
key('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, opts("show frames"))
key('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, opts("show scopes"))
key('n', '<leader>de', function() require('dapui').eval() end, opts('eval code'))
key('n', '<leader>dE', function() require('dapui').eval(vim.fn.input('[DAP] expression >')) end, opts('eval code'))

-- ############
-- # Undotree #
-- ############

key("n", "U", vim.cmd.UndotreeToggle, opts("Toggle Undotree"))

-- #######
-- # L%P #
-- #######

key('n', "gd", function() vim.lsp.buf.definition() end, opts("[G]o to [D]efinition"))
key('n', "gh", function() vim.lsp.buf.hover() end, opts("Show [h]over"))
key('n', "<leader>vs", function() vim.lsp.buf.workspace_symbol(vim.fn.expand('<cword>')) end, opts("[V]iew Workspace [symboles]"))
key('n', "<leader>vd", function() vim.diagnostic.open_float() end, opts("[G]o to [D]efinition"))
