return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- main est une reecriture incompatible avec master : plus de modules,
    -- plus de configs.setup(). Le plugin ne fournit que les parsers et les
    -- requetes, l'activation est faite par nvim.
    branch = "main",
    -- main ne supporte pas le lazy-loading, et TSUpdate doit suivre chaque
    -- mise a jour du plugin (les parsers sont lies a des versions precises).
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        -- Prepend au runtimepath : priorite sur les parsers livres avec nvim.
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- auto_install n'existe plus en main : la liste est explicite.
      -- install() est asynchrone et ne fait rien si le parser est deja la.
      ts.install({
        "bash", "c", "css", "csv", "diff", "git_config", "gitignore",
        "html", "hyprlang", "javascript", "json", "lua", "markdown",
        "markdown_inline", "php", "po", "python", "query", "sql",
        "ssh_config", "toml", "vim", "vimdoc", "xml", "yaml",
      })

      -- Indent treesitter actif partout SAUF ici. A completer au fil des
      -- constats : le module est experimental et se trompe sur les langages
      -- a imbrication libre.
      --   xml : un <record> ne cree pas de niveau (vues Odoo illisibles)
      --   php : etait deja desactive avant la migration
      local no_ts_indent = {
        -- xml = true,
        -- php = true,
      }

      local grp = vim.api.nvim_create_augroup("tubs_ts", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = grp,
        callback = function(ev)
          -- pcall : un filetype sans parser installe leverait une erreur
          -- (ex. un .conf ouvert par hasard).
          pcall(vim.treesitter.start, ev.buf)

          if not no_ts_indent[ev.match] then
            vim.bo[ev.buf].indentexpr =
              "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "topline",
      separator = "_",
      zindex = 20,
      on_attach = nil,
    },
    config = true,
  },
  {
    "andymass/vim-matchup",
    config = function()
      -- matchup se configure par variables globales. L'appel precedent a
      -- nvim-treesitter.configs.setup() ecrasait le highlight et l'indent
      -- configures dans le bloc treesitter.
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_matchparen_deferred = 1
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
