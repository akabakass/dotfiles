return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local utils = require("lualine.utils.utils")
    local highlight = require("lualine.highlight")

    local diagnostics_message = require("lualine.component"):extend()

    diagnostics_message.default = {
      colors = {
        error = utils.extract_color_from_hllist(
          { "fg", "sp" },
          { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
          "#e32636"
        ),
        warning = utils.extract_color_from_hllist(
          { "fg", "sp" },
          { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
          "#ffa500"
        ),
        info = utils.extract_color_from_hllist(
          { "fg", "sp" },
          { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
          "#ffffff"
        ),
        hint = utils.extract_color_from_hllist(
          { "fg", "sp" },
          { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
          "#273faf"
        ),
      },
    }

    function diagnostics_message:init(options)
      diagnostics_message.super:init(options)
      self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
      self.highlights = { error = "", warn = "", info = "", hint = "" }
      self.highlights.error = highlight.create_component_highlight_group(
        { fg = self.options.colors.error },
        "diagnostics_message_error",
        self.options
      )
      self.highlights.warn = highlight.create_component_highlight_group(
        { fg = self.options.colors.warn },
        "diagnostics_message_warn",
        self.options
      )
      self.highlights.info = highlight.create_component_highlight_group(
        { fg = self.options.colors.info },
        "diagnostics_message_info",
        self.options
      )
      self.highlights.hint = highlight.create_component_highlight_group(
        { fg = self.options.colors.hint },
        "diagnostics_message_hint",
        self.options
      )
    end

    function diagnostics_message:update_status(is_focused)
      local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
      local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
      if #diagnostics > 0 then
        local top = diagnostics[1]
        for _, d in ipairs(diagnostics) do
          if d.severity < top.severity then
            top = d
          end
        end
        local icons = { " ", " ", " ", " " }
        local hl = {
          self.highlights.error,
          self.highlights.warn,
          self.highlights.info,
          self.highlights.hint,
        }
        return highlight.component_format_highlight(hl[top.severity])
        .. icons[top.severity]
        .. " "
        .. utils.stl_escape(top.message)
      else
        return ""
      end
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin",
        globalstatus = true
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'buffers' },
        lualine_x = {diagnostics_message, 'hostname', 'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      }
    })

  end
}
