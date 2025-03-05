return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    dependencies = {
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
--      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history"
    },
    config = function()
      vim.opt.shortmess:append("c")
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").lazy_load() -- to use friendly-snippets

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
            select = false
          }), { "i", "c" }),
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
          },
          ["<Tab>"] = function(fallback)
            if  luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if  luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end
        },
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
          --{ name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer', keyword_length = 5 }
        }),
        formatting = {
          fields = {  "abbr", "menu", "kind" },
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
            menu = ({
              nvim_lsp = "[LSP]",
              rg = "[RG]",
              luasnip = "[Snippet]",
              luasnip_choice = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              cmdline = "[Cmdline]",
              cmdline_history = "[Cmdline_History]"
            })
          })
        }
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline_history' },
          { name = 'buffer' }
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline_history' },
          { name = 'cmdline' },
          { name = 'path' },
        }
      })

      -- add closing parenthesis on function confirm
      local Kind=cmp.lsp.CompletionItemKind
      cmp.event:on(
      'confirm_done',
      function (evt)
        if vim.tbl_contains({Kind.Function,Kind.Method},evt.entry:get_completion_item().kind) then
          vim.api.nvim_feedkeys('()'..vim.api.nvim_replace_termcodes('<Left>',true,true,true),'n',false)
        end
      end)
    end
  }
}
