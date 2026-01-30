return {
  'saghen/blink.cmp',
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "xzbdmw/colorful-menu.nvim", config = true },
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
      ['<CR>'] = { 'fallback' },
      ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-p>'] = { 'scroll_documentation_up', 'fallback' }
    },
    completion = {
      keyword = { range = 'full' },
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
      },
      documentation = { auto_show = true },
      ghost_text = { enabled = false },

      menu = {
        draw = {
          -- Utilisation de colorful-menu pour un rendu plus joli (VSCode like)
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "source_name" }
          },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        }
      }
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono'
    },
    sources = {
      default = { 'snippets', 'lazydev', 'lsp', 'dadbod', 'path', 'snippets', 'buffer' },
      providers = {
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = 1000, -- Score énorme pour forcer la 1ère position
        },
        lsp = {
          async = true,
          timeout_ms = 500,
          fallbacks = { "buffer" },
          opts = {
            trigger_characters = { '<', '>', '/', '"', ':', '.', ' '}
          }
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
          score_offset = 100
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100
        }
      }
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" }
}
