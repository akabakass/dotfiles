local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

return {
  -- a nice filetree explorer
  'nvim-tree/nvim-tree.lua',
  config = function()
    require("nvim-tree").setup({})
    -- auto close nvim when nvim-tree is the last buffer
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
      pattern = "NvimTree_*",
      callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if 
          layout[1] == "leaf" 
          and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" 
          and layout[3] == nil 
        then 
          vim.cmd("confirm quit") 
        end
      end
    })
  end,
  opts = {
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true
    },
    git = {
      -- need renderer.ions.show.git = true whereever it is
      enable = true
    },
    modified = {
      enable = true
    },
    view = {
      adaptive_size = true,
      float = {
        enable = false, -- enable that and uncomment width to get it as floating
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2)
          - vim.opt.cmdheight:get()
          return {
            border = "rounded",
            relative = "editor",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end
      },
      -- width = function()
      --   return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      -- end,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "all",
      highlight_modified = "all",
      indent_markers = {
        enable = true
      },
      icons = {
        git_placement = "before",
        show = {
          git = true
        }
      }
    }
  }
}
