Key = vim.keymap.set

Opts = function(desc)
  return {noremap = true, silent = true, desc = desc}
end

p = function(var)
  return print(vim.inspect(var))
end
require("core.defaults")
require("core.lazy")
require("core.keymaps")
require("core.filetype")
require("core.user_func")
