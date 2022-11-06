local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason")
  return
end

local status, mason_config = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("没有找到 mason-lspconfig")
  return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("没有找到 lspconfig")
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

-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
mason_config.setup({
  ensure_installed = {
    "sumneko_lua",
    "tsserver",
    "tailwindcss",
    "bashls",
    "cssls",
    "dockerls",
    "emmet_ls",
    "html",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "taplo",
    "yamlls",
    "gopls",
    "clangd",
    "cmake",
  },
})

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("insis.lsp.config.lua"), -- lua/lsp/config/lua.lua
  bashls = require("insis.lsp.config.bash"),
  pyright = require("insis.lsp.config.pyright"),
  html = require("insis.lsp.config.html"),
  cssls = require("insis.lsp.config.css"),
  emmet_ls = require("insis.lsp.config.emmet"),
  jsonls = require("insis.lsp.config.json"),
  tsserver = require("insis.lsp.config.typescript"),
  yamlls = require("insis.lsp.config.yamlls"),
  dockerls = require("insis.lsp.config.docker"),
  tailwindcss = require("insis.lsp.config.tailwindcss"),
  rust_analyzer = require("insis.lsp.config.rust"),
  taplo = require("insis.lsp.config.taplo"), -- toml
  gopls = require("insis.lsp.config.gopls"),
  -- remark_ls = require("insis.lsp.config.markdown"),
  clangd = require("insis.lsp.config.clangd"),
  cmake = require("insis.lsp.config.cmake"),
}

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
