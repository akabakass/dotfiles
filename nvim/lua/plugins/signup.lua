return {
  "Dan7h3x/signup.nvim",
  enabled = false,
  opts = {
    silent = false,
    number = true,
    icons = {
      parameter = "",
      method = "󰡱",
      documentation = "󱪙",
    },
    colors = {
      parameter = "#86e1fc",
      method = "#c099ff",
      documentation = "#4fd6be",
      default_value = "#a80888",
    },
    active_parameter_colors = {
      bg = "#86e1fc",
      fg = "#1a1a1a",
    },
    border = "solid",
    winblend = 10,
    auto_close = true,
    trigger_chars = { "(", "," },
    max_height = 10,
    max_width = 40,
    floating_window_above_cur_line = true,
    preview_parameters = true,
    debounce_time = 30,
    dock_toggle_key = "<Leader>sd",
    toggle_key = "<C-s>",
    dock_mode = {
      enabled = false,
      position = "bottom",
      height = 3,
      padding = 1,
    },
    render_style = {
      separator = true,
      compact = true,
      align_icons = true,
    }
  }
}
