-- order of plugin is important here
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

mason.setup({
  ui = {
    border = "rounded"
  }
})

local mason_lsp_status, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_status then
  return
end

mason_lsp.setup()

local lsp_status, lsp = pcall(require, "lspconfig")
if not lsp_status then
  return
end

local servers = {
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "intelephense"
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, server in ipairs(servers) do
  lsp[server].setup {
    capabilities = capabilities
  }
end
