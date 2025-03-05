Key = vim.keymap.set

Opts = function(desc)
  return {noremap = true, silent = true, desc = desc}
end
require("core.defaults")
require("core.lazy")
require("core.keymaps")
require("core.filetype")
require("core.user_func")
