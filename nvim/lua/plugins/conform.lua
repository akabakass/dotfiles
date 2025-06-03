return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        html = { "prettierd" },
        php = { "prettierd" }
      },
      log_level = vim.log.levels.DEBUG
    })
    --conform.formatters.prettierd = {
    --  prepend_args = {
    --    "--bracket-same-line"
    --  }
    --}
    Key({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500
      })
    end
    , Opts("[M]ake [P]retty"))
  end
}
