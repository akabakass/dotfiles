local nightfox_status, nightfox = pcall(require, "nightfox")
if not nightfox_status then
  return
end

nightfox.setup({
  options = {
    dim_inactive = true,
    transparent = false,
    module_default = true,
    styles = {
      comments = "italic,bold",
      functions = "italic,bold",
      keywords = "bold"
      -- test
    }
  }
})
vim.cmd("colorscheme nordfox")

local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
  return
end

treesitter.setup({
  ensure_installed = "all",
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true
  },
  autopairs = {
    enable = true
  },
  rainbow = {
    enable = true,
    -- Which query to use for finding delimiters
    query = {
      'rainbow-parens',
      html = "rainbow-tags"
    },
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  }
})

