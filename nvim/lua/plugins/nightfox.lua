return {
  -- color scheme
  "EdenEast/nightfox.nvim",
  opts = {
    options = {
      dim_inactive = true,
      transparent = false,
      module_default = true,
      styles = {
        comments = "italic,bold",
        functions = "italic,bold",
        keywords = "bold"
        -- test
      }
    }
  },
  config = function()
    vim.cmd("colorscheme nordfox")
  end
}
