local mason = pRequire("mason")
local mason_config = pRequire("mason-lspconfig")
local lspconfig = pRequire("lspconfig")

if not mason or not mason_config or not lspconfig then
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

local ensure_installed, servers = require("insis.utils.config-helper").getMasonEnsureList()
-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
mason_config.setup({
  ensure_installed = ensure_installed,
})

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- local servers = {
--   sumneko_lua = require("insis.lsp.config.lua"), -- lua/lsp/config/lua.lua
--   bashls = require("insis.lsp.config.bash"),
--   -- pyright = require("insis.lsp.config.pyright"),
--   pylsp = require("insis.lsp.config.pylsp"),
--   html = require("insis.lsp.config.html"),
--   cssls = require("insis.lsp.config.css"),
--   emmet_ls = require("insis.lsp.config.emmet"),
--   jsonls = require("insis.lsp.config.json"),
--   -- DEPRECATE
--   -- tsserver = require("insis.lsp.config.ts"),
--   tsserver = require("insis.lsp.config.typescript"),
--   yamlls = require("insis.lsp.config.yamlls"),
--   dockerls = require("insis.lsp.config.docker"),
--   tailwindcss = require("insis.lsp.config.tailwindcss"),
--   rust_analyzer = require("insis.lsp.config.rust"),
--   taplo = require("insis.lsp.config.taplo"), -- toml
--   gopls = require("insis.lsp.config.gopls"),
--   -- remark_ls = require("insis.lsp.config.markdown"),
--   clangd = require("insis.lsp.config.clangd"),
--   cmake = require("insis.lsp.config.cmake"),
-- }

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end

require("insis.lsp.ui")
