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

-- navigate quickfix list
Key('n', '<C-S-j>', "<cmd>cnext<CR>")
Key('n', '<C-S-k>', "<cmd>cprev<CR>")

-- open terminal
Key('n', '<leader>st',
function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 15)
end,
Opts('open [S]mall [T]erminal')
)

-- #############
-- # nvim-tree #
-- #############

Key("n", "<C-a>", ":NvimTreeFindFileToggle<CR>", Opts())

-- #############
-- # telescope #
-- #############

local telescope_b_status, telescope_b = pcall(require, "telescope.builtin")
if telescope_b_status then
  local my_find_files
  my_find_files = function(opts, no_ignore)
    opts = opts or {}
    no_ignore = vim.F.if_nil(no_ignore, false)
    opts.attach_mappings = function(_, map)
      map({ "n", "i" }, "<C-f>", function(prompt_bufnr) -- <C-h> to toggle modes
        local prompt = require("telescope.actions.state").get_current_line()
        require("telescope.actions").close(prompt_bufnr)
        no_ignore = not no_ignore
        my_find_files({ default_text = prompt }, no_ignore)
      end)
      return true
    end

    if no_ignore then
      opts.no_ignore = true
      opts.hidden = true
      opts.prompt_title = "Find Files <ALL>"
      require("telescope.builtin").find_files(opts)
    else
      opts.prompt_title = "Find Files"
      require("telescope.builtin").find_files(opts)
    end
  end

  Key("n", "<leader>tt", telescope_b.resume, Opts("resume [TT]elescope"))
  Key("n", "<leader>ff", my_find_files, Opts("[F]ind [F]iles"))
  Key("n", "<leader>gl", telescope_b.live_grep, Opts("[G]rep [L]ive"))
  Key("n", "<leader>gs", telescope_b.grep_string, Opts("[G]rep [S]tring"))
  Key("n", "<leader>fh", telescope_b.help_tags, Opts("[F]ind [H]elp"))
  Key("n", "<leader>fb", telescope_b.buffers, Opts("[F]ind [B]uffer"))
  Key("n", "<leader>fs", telescope_b.lsp_document_symbols, Opts("[F]ind [S]ymbols"))
  Key("n", "<leader>fm", function() telescope_b.lsp_document_symbols({symbols={'function', 'method'}}) end, Opts("[F]ind [M]ethods"))
  Key('n', "<leader>fr", telescope_b.lsp_references, Opts("[F]ind [R]eferences"))
  Key('n', "<leader>fd", telescope_b.lsp_definitions, Opts("[F]ind [D]efinitions"))
  Key('n', "<leader>fy", telescope_b.registers, Opts("[F]ind [Y]anks"))
  Key('n', "<leader>fq", telescope_b.quickfix, Opts("[F]ind [Q]uickfix"))
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
Key("n", "<leader>drc", function() require("dap").run_to_cursor() end, Opts("[D]ap [R]un to [C]ursor"))
Key("n", "<leader>de", function() require("dapui").eval(nil, { enter = true }) end, Opts("[D]ap [E]val"))
Key('n', '<leader>dE', function() require('dapui').eval(vim.fn.input('[DAP] expression >'), { enter = true }) end, Opts('[d]ap input [E]val code'))
Key("n", "<leader>dw", function() require("dapui").elements.watches.add() end, Opts("[D]ap [W]atch"))
Key('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, Opts("[D]ap Toggle [B]reakpoint"))
Key('n', '<Leader>dcb', function() require('dap').toggle_breakpoint(vim.fn.input('Breakpoint condition : '), nil, nil) end, Opts("[D]ap Set [C]onditional [B]reakpoint"))
Key('n', '<Leader>dlb', function() require('dap').toggle_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, Opts("[D]ap Set [L]og [B]reakpoint"))
Key('n', '<Leader>dre', function() require('dap').repl.open() end, Opts("[D]ap open [RE]pl"))
Key('n', '<Leader>dl', function() require('dap').run_last() end, Opts("[D]ap run [L]ast"))
Key({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, Opts("[D]ap show [H]over info"))
Key({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, Opts("[D]ap show [P]review info"))
Key('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, Opts("[D]ap show [F]rames"))
Key('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, Opts("[d]ap show [S]copes"))

-- ############
-- # Undotree #
-- ############

Key("n", "U", vim.cmd.UndotreeToggle, Opts("Toggle Undotree"))

-- #######
-- # L%P #
-- #######

Key('n', "<leader>gd", function() vim.lsp.buf.definition() end, Opts("[G]o to [D]efinition"))
Key('n', "<leader>sh", function() vim.lsp.buf.hover() end, Opts("[S]how [h]over"))
Key('n', "<leader>ss", function() vim.lsp.buf.signature_help() end, Opts("[S]how [S]ignature"))
Key('n', "<leader>vs", function() vim.lsp.buf.workspace_symbol(vim.fn.expand('<cword>')) end, Opts("[V]iew Workspace [symboles]"))
Key('n', "<leader>vd", function() vim.diagnostic.open_float() end, Opts("[G]o to [D]efinition"))

-- ##########
-- # dadbod #
-- ##########

Key("n", "<leader>dB", "<cmd>DBUIToggle<CR>", Opts("[DB]ui"))
Key("n", "<leader>rq", "<plug>DBUI_ExecuteQuery<CR>", Opts("[DB]ui"))


-- #############
-- # lua debug #
-- #############

Key('n', "<leader><leader>x", "<cmd>source %<CR>", Opts("Source current file"))
Key('n', "<leader>x", ":.lua<CR>", Opts("Execute current lua line"))
Key('v', "<leader>x", ":lua<CR>", Opts("Execute selected lua lines"))


-- #######
-- # oil #
-- #######

Key('n', '-', '<cmd>Oil<CR>', Opts("Launch Oil"))
