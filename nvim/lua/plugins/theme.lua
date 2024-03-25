-- return {
--   -- color scheme
--   "EdenEast/nightfox.nvim",
--   opts = {
--     options = {
--       dim_inactive = true,
--       transparent = false,
--       module_default = true,
--       styles = {
--         comments = "italic,bold",
--         functions = "italic,bold",
--         keywords = "bold"
--         -- test
--       }
--     }
--   },
--   config = function()
--     vim.cmd("colorscheme nordfox")
--   end
-- }

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme catppuccin")
  end,
  opts = {
    -- flavour = "mocha",
    transparent_background = true,
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.15
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      treesitter_context = true,
      ts_rainbow2 = true,
      notify = true,
      dashboard = true,
      indent_blankline = {
        enabled = true,
        scope_color = "",
        colored_indent_levels = true
      },
      mason = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" }
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" }
        },
        inlay_hints = {
          background = true
        }
      },
      telescope = {
        enabled = true
      },
      which_key = true
    }
  }
}
