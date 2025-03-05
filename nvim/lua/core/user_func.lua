-- Highlight Yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highlight yanked text for a brief moment",
  group = vim.api.nvim_create_augroup('Highlight-yank', {
    clear = true
  }),
  callback = function ()
    vim.highlight.on_yank()
  end
})

-- improve term
vim.api.nvim_create_autocmd('TermOpen', {
  desc = "improve term launch",
  group = vim.api.nvim_create_augroup('Highlight-yank', {
    clear = true
  }),
  callback = function()

  end
})
