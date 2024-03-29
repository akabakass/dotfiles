local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

return {
  -- a nice filetree explorer
  'nvim-tree/nvim-tree.lua',
  config = function()
    require("nvim-tree").setup({})
    -- auto close nvim when nvim-tree is the last buffer
    local function tab_win_closed(winnr)
      local api = require"nvim-tree.api"
      local tabnr = vim.api.nvim_win_get_tabpage(winnr)
      local bufnr = vim.api.nvim_win_get_buf(winnr)
      local buf_info = vim.fn.getbufinfo(bufnr)[1]
      local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
      local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
      if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
        -- Close all nvim tree on :q
        if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
          api.tree.close()
        end
      else                                                      -- else closed buffer was normal buffer
        if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
          local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
          if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
            vim.schedule(function ()
              if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
                vim.cmd "quit"                                        -- then close all of vim
              else                                                  -- else there are more tabs open
                vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
              end
            end)
          end
        end
      end
    end

    vim.api.nvim_create_autocmd("WinClosed", {
      callback = function ()
        local winnr = tonumber(vim.fn.expand("<amatch>"))
        vim.schedule_wrap(tab_win_closed(winnr))
      end,
      nested = true
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
