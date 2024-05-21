-- Key("", "<Space>", "<Nop>", Opts("set space as leader"))
-- ###############
-- # NORMAL MODE #
-- ###############

Key('n', '<C-n>', ":Dashboard<CR>", Opts("launch dashboard"))


--easy resizing with arrow Keys
Key('n', "<C-Up>", ":resize -2<CR>", Opts())
Key('n', "<C-Down>", ":resize +2<CR>", Opts())
Key('n', "<C-Left>", ":vertical resize -2<CR>", Opts())
Key('n', "<C-Right>", ":vertical resize +2<CR>", Opts())

-- auto instert date and time
Key('n', "<F9>", "i<C-R>=strftime('%Y-%m-%d %H:%M')<CR>")
Key('i', "<F9>", "<C-R>=strftime('%Y-%m-%d %H:%M')<CR>")


-- #############
-- # nvim-tree #
-- #############

Key("n", "<C-a>", ":NvimTreeToggle<CR>", Opts())
Key("n", "<C-f>", ":NvimTreeFindFileToggle<CR>", Opts())

-- #############
-- # telescope #
-- #############

local telescope_b_status, telescope_b = pcall(require, "telescope.builtin")
if telescope_b_status then
  Key("n", "<leader>ff", telescope_b.find_files, Opts("[F]ind [F]iles"))
  Key("n", "<leader>gl", telescope_b.live_grep, Opts("[G]rep [L]ive"))
  Key("n", "<leader>gs", telescope_b.grep_string, Opts("[G]rep [S]tring"))
  Key("n", "<leader>fh", telescope_b.help_tags, Opts("[F]ind [H]elp"))
  Key("n", "<leader>fb", telescope_b.buffers, Opts("[F]ind [B]uffer"))
  Key("n", "<leader>fs", telescope_b.lsp_document_symbols, Opts("[F]ind [S]ymbols"))
  Key("n", "<leader>fm", function() telescope_b.lsp_document_symbols({symbols={'function', 'method'}}) end, Opts("[F]ind [M]ethods"))
  Key('n', "<leader>fr", telescope_b.lsp_references, Opts("[F]ind [R]eferences"))
  Key('n', "<leader>fd", telescope_b.lsp_definitions, Opts("[F]ind [D]efinitions"))
  Key('n', "<leader>fy", telescope_b.registers, Opts("[F]ind [Y]anks"))
  Key("n", "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({hidden = true}))<CR>", Opts("[F]ind [P]roject"))
end
Key("n", "<leader>u", "<cmd>Telescope undo<CR>")
-- ############
-- # cellular #
-- ############

Key("n", "<leader>fuc", "<cmd>CellularAutomaton make_it_rain<CR>", Opts('make it rain'))
Key("n", "<leader>fuk", "<cmd>CellularAutomaton game_of_life<CR>", Opts('game of life'))

-- ############
-- # fugitive #
-- ############

Key('n', '<leader>gg', '<cmd>Git<CR>', Opts('[G]it [S]tatus'))

-- ##############
-- # treehopper #
-- ##############

Key('o', 'm', ":<C-U>lua require('tsht').nodes()<CR>", {silent = true, desc = "treehopper"})
Key('x', 'm', ":lua require('tsht').nodes()<CR>", Opts("treehopper"))

-- #######
-- # DAP #
-- #######

Key('n', '<F5>', function() require('dap').continue() end, Opts("Start debbuging"))
Key('n', '<F6>', function()
  require('dap').close()
  require('dapui').close()
end, Opts("Stop debugging"))
Key('n', '<F2>', function() require('dap').step_over() end, Opts("Step over"))
Key('n', '<F3>', function() require('dap').step_into() end, Opts("Step into"))
Key('n', '<F4>', function() require('dap').step_out() end, Opts("Step out"))
Key('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, Opts("Toggle breakpoint"))
Key('n', '<Leader>B', function() require('dap').toggle_breakpoint(vim.fn.input('Breakpoint condition : '), nil, nil) end, Opts("Set conditional breakpoint"))
Key('n', '<Leader>lb', function() require('dap').toggle_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, Opts("Set log breakpoint"))
Key('n', '<Leader>dr', function() require('dap').repl.open() end, Opts("open repl"))
Key('n', '<Leader>dl', function() require('dap').run_last() end, Opts("run last"))
Key({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, Opts("show hover info"))
Key({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, Opts("show preview info"))
Key('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, Opts("show frames"))
Key('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, Opts("show scopes"))
Key('n', '<leader>de', function() require('dapui').eval() end, Opts('eval code'))
Key('n', '<leader>dE', function() require('dapui').eval(vim.fn.input('[DAP] expression >')) end, Opts('eval code'))

-- ############
-- # Undotree #
-- ############

Key("n", "U", vim.cmd.UndotreeToggle, Opts("Toggle Undotree"))

-- #######
-- # L%P #
-- #######

Key('n', "gd", function() vim.lsp.buf.definition() end, Opts("[G]o to [D]efinition"))
Key('n', "gh", function() vim.lsp.buf.hover() end, Opts("Show [h]over"))
Key('n', "<leader>vs", function() vim.lsp.buf.workspace_symbol(vim.fn.expand('<cword>')) end, Opts("[V]iew Workspace [symboles]"))
Key('n', "<leader>vd", function() vim.diagnostic.open_float() end, Opts("[G]o to [D]efinition"))

-- ##########
-- # dadbod #
-- ##########

Key("n", "<leader>db", function ()
  vim.api.nvim_command('tabnew')
  vim.api.nvim_command('DBUI')
  print('yay')
end, Opts("[DB]ui"))
