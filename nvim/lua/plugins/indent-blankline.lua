return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    exclude = {
      filetypes = {
        'dashboard'
      }
    }
  },
  config = true
}
-- vim.g.indent_blankline_filetype_exclude = {'dashboard'}
-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#353949 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#36493C gui=nocombine]]

-- bindent_blankline.setup ({
-- b  indent = {
-- b    char = "▎",
-- b    highlight = {
-- b      "IndentBlanklineIndent1",
-- b      "IndentBlanklineIndent2",
-- b    }
-- b  },
-- b  whitespace = {
-- b    highlight = {
-- b      "IndentBlanklineIndent1",
-- b      "IndentBlanklineIndent2",
-- b    },
-- b    remove_blankline_trail = true,
-- b  },
-- b})
-- b
