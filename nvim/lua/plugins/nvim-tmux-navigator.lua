return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    local nvim_tmux_nav = require('nvim-tmux-navigation')
    local key = vim.keymap.set
    local opts = function(desc)
      return {noremap = true, silent = true, desc = desc}
    end
    key('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, opts("move to lefter window"))
    key('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, opts("move to lower window"))
    key('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, opts("move to upper window"))
    key('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, opts("move to righter window"))
  end
}
