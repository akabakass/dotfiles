return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "MattiasMTS/cmp-dbee",
        ft = "sql",
        opts = {}
      }
    },
    config = function()
      vim.opt.shortmess:append("c")
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require("luasnip.loaders.from_vscode").lazy_load() -- to use friendly-snippets
      local kind_icons = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }

      cmp.setup({
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter
          },
          completeopt = "menuone,noinsert,noselect",
          -- keyword_length = 0
          max_item_count = 3
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<CR>"] = cmp.mapping(cmp.mapping.confirm({
            cmp.ConfirmBehavior.insert,
            select = true
          }), { "i", "c" }),
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
          }
        },
        sources = cmp.config.sources({
          { name = "cmp-dbee" },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer', keyword_length = 5 }
        },
        {
          { name = 'buffer'}
        }),
        formatting = {
          fields = {  "abbr", "menu", "kind" },
          format = function(entry, vim_item)
            -- Kind icons
            -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              rg = "[RG]",
              luasnip = "[Snippet]",
              luasnip_choice = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              cmdline = "[Cmdline]",
              cmdline_history = "[Cmdline_History]"
            })[entry.source.name]
            return vim_item
          end
        }
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline' },
          { name = 'path' },
        }
      })
      Key({'i', 's'}, "<Tab>", function()
        if  luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, {silent = true})
      Key({'i', 's'}, "<S-Tab>", function()
        if  luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, {silent = true})
    end
  }
}
