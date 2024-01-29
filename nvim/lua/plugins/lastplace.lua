
  -- jump back to last place when opening a file
return {
  'ethanholz/nvim-lastplace',
  config = function()
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" }
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }
    lastplace_open_folds = true
  end
}
