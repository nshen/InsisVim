local mason = pRequire("mason")
local mason_config = pRequire("mason-lspconfig")
local lspconfig = pRequire("lspconfig")
local mason_tool = pRequire("mason-tool-installer")

if not mason or not mason_config or not lspconfig or not mason_tool then
  return
end

-- :h mason-default-settings
-- ~/.local/share/nvim/mason
mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_config.setup({
  ensure_installed = require("insis.env").getLSPEnsureList(),
})

mason_tool.setup({
  ensure_installed = require("insis.env").getToolEnsureList(),
})

local servers = require("insis.env").getLSPConfigMap()
for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- config file must implement on_setup method
    config.on_setup(lspconfig[name])
  else
    -- or else use default params
    lspconfig[name].setup({})
  end
end

require("insis.lsp.ui")
