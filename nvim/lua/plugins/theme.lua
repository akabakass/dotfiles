-- return {
--   -- color scheme
--   "EdenEast/nightfox.nvim",
--   opts = {
--     options = {
--       dim_inactive = true,
--       transparent = false,
--       module_default = true,
--       styles = {
--         comments = "italic,bold",
--         functions = "italic,bold",
--         keywords = "bold"
--         -- test
--       }
--     }
--   },
--   config = function()
--     vim.cmd("colorscheme nordfox")
--   end
-- }

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme catppuccin")
  end,
  opts = {
    -- flavour = "mocha",
    transparent_background = true,
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.15
    }
  }
}
