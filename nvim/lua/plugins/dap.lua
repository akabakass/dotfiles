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

    -- Tailles calculees au chargement : la meme config sert sur le grand ecran
    -- et en SSH depuis le ThinkPad. Des valeurs absolues rendraient la colonne
    -- de gauche inutilisable sur la petite fenetre.
    local function clamp(v, lo, hi)
      return math.max(lo, math.min(hi, v))
    end

    -- 32% de la largeur, borne : sous 42 colonnes les noms de champs Odoo sont
    -- tronques, au dela de 70 on vole de la place au code.
    local side_w  = clamp(math.floor(vim.o.columns * 0.32), 42, 70)
    -- 22% de la hauteur : le REPL sert a taper des expressions, pas a lire.
    local repl_h  = clamp(math.floor(vim.o.lines * 0.22), 8, 18)
    local right_w = clamp(math.floor(vim.o.columns * 0.30), 40, 60)

    dap_ui.setup({
      -- Sans 'expand_lines', une valeur plus large que la fenetre est tronquee
      -- sans moyen de la lire. Avec, <CR> l'ouvre dans un flottant.
      expand_lines = false,
      layouts = {
        {
          -- 'console' et 'stacks' retires : console reste vide en mode attach
          -- (le process est lance par systemd, pas par DAP) et stacks liste la
          -- dizaine de threads d'Odoo dont un seul nous interesse.
          elements = {
            { id = "scopes",  size = 0.4 },
            { id = "watches", size = 0.6 },
          },
          size = side_w,
          position = "left",
        },
        {
          elements = { "repl" },
          size = repl_h,
          position = "bottom",
        },
        {
          -- Layout 3 : jamais ouvert automatiquement, uniquement sur <leader>dt
          elements = { "stacks", "breakpoints" },
          size = right_w,
          position = "right",
        },
      },
      floating = {
        max_width = 0.9,
        max_height = 0.8,
        border = "rounded",
      },
      render = {
        indent = 2,
        -- Un repr de recordset Odoo peut etre tres long : on le borne pour ne
        -- pas noyer la liste des variables.
        max_value_lines = 15,
      },
    })

    -- open() sans argument ouvrirait AUSSI le layout 3 : on designe 1 et 2.
    local function open_debug_layouts(reset)
      dap_ui.open({ layout = 1, reset = reset })
      dap_ui.open({ layout = 2, reset = reset })
    end

    dap.listeners.before.attach.dapui_config = function()
      open_debug_layouts(false)
    end
    dap.listeners.after.event_initialized.dapui_config = function()
      open_debug_layouts(true)
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
        -- Pas de pathMappings ni de mode remote : Odoo tourne sur CETTE machine.
        -- Un mapping base sur ${workspaceFolder} ferait ignorer en silence tout
        -- point d'arret pose hors du cwd de nvim (ex. le source Odoo standard).
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
