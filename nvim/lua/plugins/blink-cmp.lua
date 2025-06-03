return {
  'saghen/blink.cmp',
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  opts = {
    keymap = {
      preset = 'default',
      ['<C-j>'] = {'select_next', 'fallback'},
      ['<C-k>'] = {'select_prev', 'fallback'},
      ['<Tab>'] = {'select_and_accept', 'fallback'},
      --  ['<Esc>'] = {'hide', 'fallback'},
      ['<C-n>'] = {'scroll_documentation_down', 'fallback'},
      ['<C-p>'] = {'scroll_documentation_up', 'fallback'}
    },
    completion = {
      keyword = {
        range = 'full'
      },
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
        show_on_insert_on_trigger_character = true
      },
      documentation = {
        auto_show = true
      },
      ghost_text = {
        enabled = false
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false
        }
      },
      accept = {
        dot_repeat = true,
        create_undo_point = true,
        auto_brackets = {
          enabled = true,
          kind_resolution = {
            enabled = true
          },
          semantic_token_resolution = {
            enabled = true,
            timeout_ms = 400
          }
        }
      },
      menu = {
        draw = {
          columns = {
            {"kind_icon", "label", gap = 1},
            {"source_name"}
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
      default = {
        'lazydev',
        'lsp',
        'dadbod',
        'path',
        'snippets',
        'buffer'
      },
      providers = {
        lsp = {
          async = true,
          timeout_ms = 500
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink"
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100
        }
      }
    },
    fuzzy = {
      implementation = "rust"
    },
    signature = {
      enabled = true
    },
    cmdline = {
      enabled = true,
      keymap = {
        ['<C-j>'] = {'select_next', 'fallback'},
        ['<C-k>'] = {'select_prev', 'fallback'},
        ['<Tab>'] = {'select_and_accept', 'fallback'},
        ['<C-n>'] = {'scroll_documentation_down', 'fallback'},
        ['<C-p>'] = {'scroll_documentation_up', 'fallback'}

      },
      completion = {
        menu = {
          auto_show = true
        }
      }
    }

  },
  opts_extend = { "sources.default" }
}
