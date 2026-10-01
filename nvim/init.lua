Key = vim.keymap.set

Opts = function(desc)
  return {noremap = true, silent = true, desc = desc}
end

p = function(var)
  return print(vim.inspect(var))
end
require("core.defaults")

-- ts_context_commentstring appelle nvim-treesitter.configs (API master,
-- absente de main) dans son M.attach() deprecie, sans pcall. doit être avant core.lazy
vim.g.skip_ts_context_commentstring_module = true

require("core.lazy")
require("core.keymaps")
require("core.filetype")
require("core.user_func")
require("user.odoo")
