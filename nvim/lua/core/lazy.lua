local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- auto source and resync when packer_install.lua is saved
vim.api.nvim_create_autocmd('BufWritePost', {
  command = "source <afile> | LazySync",
  group = vim.api.nvim_create_augroup("lazy_install", {clear = true}),
  pattern = vim.fn.expand("lazy_install.lua")
})

