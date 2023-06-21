local indent_blankline_status, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_status then
  return
end

vim.g.indent_blankline_filetype_exclude = {'dashboard'}
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#353949 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#36493C gui=nocombine]]

require("indent_blankline").setup {
  char = "",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
}
