return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text"
  },
  config = function()
    local dap = require('dap')
    local dap_ui = require('dapui')
    local dap_virtual_text = require('nvim-dap-virtual-text')
    dap_virtual_text.setup({
      enabled = true
    })
    vim.g.dap_virtual_text = true
    dap_ui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dap_ui.open()
    end
    dap.listeners.after.event_initialized.dapui_config = function()
      dap_ui.open({
        reset = true
      })
    end
    dap.listeners.before.event_terminated.nvim_dap_ui_config = function()
      dap_ui.close()
    end
    dap.listeners.before.event_exited.nvim_dap_ui_config = function()
      dap_ui.close()
    end


    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = {
        '/home/jc/dotfiles/nvim/src/vscode-php-debug/out/phpDebug.js'
      }
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9001
      }
    }
    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
          type = 'server',
          port = assert(port, '`connect.port` is required for a python `attach` configuration'),
          host = host,
          options = { source_filetype = 'python' },
        })
      else
        cb({
          type = 'executable',
          command = '/usr/bin/python3', -- Chemin explicite vers le python système
          args = { '-m', 'debugpy.adapter' },
          options = { source_filetype = 'python' },
        })
      end
    end

    dap.configurations.python = {
      {
        type = 'python',
        request = 'attach',
        name = "Odoo: Attach Server",
        connect = {
          host = '127.0.0.1',
          port = 5678
        },
        mode = "remote",
        pathMappings = {
            {
                localRoot = "${workspaceFolder}",
                remoteRoot = "${workspaceFolder}"
            }
        },
        justMyCode = false,
      },
    }

    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}"
      }
    }

  end
}
