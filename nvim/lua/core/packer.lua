-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- auto source and resync when packer_install.lua is saved
vim.api.nvim_create_autocmd('BufWritePost', {
  command = "source <afile> | PackerSync",
  group = vim.api.nvim_create_augroup("packer_install", {clear = true}),
  pattern = vim.fn.expand("packer_install.lua")
})

