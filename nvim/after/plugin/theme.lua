local nightfox_status, nightfox = pcall(require, "nightfox")
if not nightfox_status then
  return
end

nightfox.setup({
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
})
vim.cmd("colorscheme nordfox")

