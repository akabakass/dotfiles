return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    local nvim_tmux_nav = require('nvim-tmux-navigation')
    Key('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, Opts("move to lefter window"))
    Key('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, Opts("move to lower window"))
    Key('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, Opts("move to upper window"))
    Key('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, Opts("move to righter window"))
  end
}
