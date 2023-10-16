local indent_blankline_status, indent_blankline = pcall(require, "ibl")
if not indent_blankline_status then
  return
end

vim.g.indent_blankline_filetype_exclude = {'dashboard'}
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#353949 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#36493C gui=nocombine]]

indent_blankline.setup ({
  indent = {
    char = "▎",
    highlight = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
    }
  },
  whitespace = {
    highlight = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
    },
    remove_blankline_trail = true,
  },
  exclude = {
    filetypes = {
      'dashboard'
    }
  }
})
