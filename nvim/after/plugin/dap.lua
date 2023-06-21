local nvim_dap_status, nvim_dap = pcall(require, "dap")
if not nvim_dap_status then
  return
end

nvim_dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {
    '/home/jc/dotfiles/nvim/src/vscode-php-debug/out/phpDebug.js'
  }
}

nvim_dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9001
  }
}

local nvim_dap_ui_status, nvim_dap_ui = pcall(require, "dapui")
if nvim_dap_ui_status then
  nvim_dap_ui.setup()
  nvim_dap.listeners.after.event_initialized["dapui_config"] = function()
    nvim_dap_ui.open({
      reset = true
    })
  end
  nvim_dap.listeners.before.event_terminated["nvim_dap_ui_config"] = function()
    nvim_dap_ui.close()
  end
  nvim_dap.listeners.before.event_exited["nvim_dap_ui_config"] = function()
    nvim_dap_ui.close()
  end
end

local nvim_virtual_text_status, nvim_virtual_text = pcall(require, "nvim-dap-virtual-text")
if nvim_virtual_text_status then
  nvim_virtual_text.setup(
  {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = true,                -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
    -- --- A callback that determines how a variable is displayed or whether it should be omitted
    -- --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    -- --- @param buf number
    -- --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    -- --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    -- --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
    -- --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    -- -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == 'inline' then
        return ' = ' .. variable.value
      else
        return variable.name .. ' = ' .. variable.value
      end
    end,

    -- experimental features:
    all_frames = true,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
  }
  )
end

local nvim_dap_repl_highlight_status, nvim_dap_repl_highlight = pcall(require, 'nvim-dap-repl-highlights')
if nvim_dap_repl_highlight_status then
  nvim_dap_repl_highlight.setup({

  })
end

require("cmp").setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})
