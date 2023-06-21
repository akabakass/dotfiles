-- order of plugin is important here
local mason_status, mason = pcall(require, "mason")
if mason_status then
  mason.setup({
    ui = {
      border = "rounded"
    }
  })
end

local neodev_status, neodev = pcall(require, "neodev")
if neodev_status then
  neodev.setup({
    library = { 
      plugins = { 
        "nvim-dap-ui" 
      }, 
      types = true 
    }
  })
end

local mason_lsp_status, mason_lsp = pcall(require, "mason-lspconfig")
if mason_lsp_status then
  mason_lsp.setup()
  mason_lsp.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup ({
              root_dir = function() return vim.loop.cwd() end
            })
        end,
    }
end

local mason_tools_status, mason_tools = pcall(require, "mason-tool-installer")
if mason_tools_status then
  mason_tools.setup({
    auto_update = true,
    run_on_start = true
  })
end

