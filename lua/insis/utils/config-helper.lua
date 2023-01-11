local M = {}

-- get treesitter parser list from config file
M.getTSEnsureList = function()
  local cfg = require("insis").config
  local parserSet = {}

  if cfg.frontend and cfg.frontend.enable then
    for _, value in pairs(cfg.frontend.highlight) do
      parserSet[value] = true
    end
  end

  if cfg.clangd and cfg.clangd.enable then
    parserSet["cpp"] = true
    parserSet["c"] = true
  end

  if cfg.golang and cfg.golang.enable then
    parserSet["go"] = true
  end

  if cfg.lua and cfg.lua.enable then
    parserSet["lua"] = true
  end

  if cfg.rust and cfg.rust.enable then
    parserSet["rust"] = true
  end

  if cfg.sh and cfg.sh.enable then
    parserSet["bash"] = true
  end

  if cfg.python and cfg.python.enable then
    parserSet["python"] = true
  end

  if cfg.ruby and cfg.ruby.enable then
    parserSet["ruby"] = true
  end

  if cfg.json and cfg.json.enable then
    parserSet["json"] = true
  end

  if cfg.markdown and cfg.markdown.enable then
    parserSet["markdown"] = true
  end

  local ensureInstalled = {}
  for key, _ in pairs(parserSet) do
    table.insert(ensureInstalled, key)
  end
  return ensureInstalled
end

-- add sources based on config file
M.getNulllsSources = function()
  local null_ls = pRequire("null-ls")
  local cfg = require("insis").config
  if not null_ls then
    return nil
  end
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions
  local formatterMap = {
    stylua = formatting.stylua,
    shfmt = formatting.shfmt,
    gofmt = formatting.gofmt,
    rustfmt = formatting.rustfmt,
    eslint_d = formatting.eslint_d,
    prettier = formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "graphql",
        -- "json",
        -- "yaml",
        -- "markdown",
      },
      timeout = 10000,
      prefer_local = "node_modules/.bin",
    }),
    black = formatting.black.with({ extra_args = { "--fast" } }),
    rubocop = formatting.rubocop,
    fixjson = formatting.fixjson,
  }
  local linterMap = {
    golangci_lint = diagnostics.golangci_lint,
    eslint_d = diagnostics.eslint_d,
  }
  local codeActionMap = {
    eslint_d = code_actions.eslint_d,
    gitsigns = code_actions.gitsigns,
  }
  local sources = {}
  if cfg.frontend and cfg.frontend.enable then
    local formatter = formatterMap[cfg.frontend.formatter]
    local linter = linterMap[cfg.frontend.linter]
    local ca = codeActionMap[cfg.frontend.code_actions]
    if formatter then
      table.insert(sources, formatter)
    end
    if linter then
      table.insert(sources, linter)
    end
    if ca then
      table.insert(sources, ca)
    end
  end
  if cfg.golang and cfg.golang.enable then
    local formatter = formatterMap[cfg.golang.formatter]
    local linter = linterMap[cfg.golang.linter]
    if formatter then
      table.insert(sources, formatter)
    end
    if linter then
      table.insert(sources, linter)
    end
  end
  if cfg.lua and cfg.lua.enable then
    local formatter = formatterMap[cfg.lua.formatter]
    if formatter then
      table.insert(sources, formatter)
    end
  end
  if cfg.rust and cfg.rust.enable then
    local formatter = formatterMap[cfg.rust.formatter]
    if formatter then
      table.insert(sources, formatter)
    end
  end
  if cfg.sh and cfg.sh.enable then
    local formatter = formatterMap[cfg.sh.formatter]
    if formatter then
      table.insert(sources, formatter)
    end
  end
  if cfg.python and cfg.python.enable then
    local formatter = formatterMap[cfg.python.formatter]
    if formatter then
      table.insert(sources, formatter)
    end
  end
  if cfg.ruby and cfg.ruby.enable then
    local formatter = formatterMap[cfg.ruby.formatter]
    if formatter then
      table.insert(sources, formatter)
    end
  end

  if cfg.json and cfg.json.enable then
    if cfg.json.formatter == "fixjson" then
      table.insert(sources, formatting.fixjson)
    elseif cfg.json.formatter == "prettier" then
      table.insert(
        sources,
        formatting.prettier.with({
          filetypes = { "json" },
        })
      )
    end
  end
  if cfg.yaml and cfg.yaml.enable then
    if cfg.yaml.formatter == "prettier" then
      table.insert(
        sources,
        formatting.prettier.with({
          filetypes = { "yaml" },
        })
      )
    end
  end
  if cfg.git and cfg.git.enable then
    local ca = codeActionMap[cfg.git.code_actions]
    if ca then
      table.insert(sources, code_actions.gitsigns)
    end
  end
  return sources
end

M.getFormatOnSavePattern = function()
  local cfg = require("insis").config
  local pattern = {}
  if cfg.frontend and cfg.frontend.enable then
    if cfg.frontend.typescript.format_on_save then
      table.insert(pattern, "*.ts")
      table.insert(pattern, "*.tsx")
    end
  end
  if cfg.clangd and cfg.clangd.enable then
    if cfg.clangd.format_on_save then
      table.insert(pattern, "*.c")
      table.insert(pattern, "*.cpp")
      table.insert(pattern, "*.cc")
    end
  end
  if cfg.golang and cfg.golang.enable then
    if cfg.golang.format_on_save then
      table.insert(pattern, "*.go")
    end
  end
  if cfg.lua and cfg.lua.enable then
    if cfg.lua.format_on_save then
      table.insert(pattern, "*.lua")
    end
  end
  if cfg.rust and cfg.rust.enable then
    if cfg.rust.format_on_save then
      table.insert(pattern, "*.rs")
    end
  end
  if cfg.sh and cfg.sh.enable then
    if cfg.sh.format_on_save then
      table.insert(pattern, "*.sh")
    end
  end
  if cfg.python and cfg.python.enable then
    if cfg.python.format_on_save then
      table.insert(pattern, "*.py")
    end
  end
  if cfg.ruby and cfg.ruby.enable then
    if cfg.ruby.format_on_save then
      table.insert(pattern, "*.rb")
    end
  end
  if cfg.json and cfg.json.enable then
    if cfg.json.format_on_save then
      table.insert(pattern, "*.json")
    end
  end
  -- markdown
  -- toml
  if cfg.yaml and cfg.yaml.enable then
    if cfg.yaml.format_on_save then
      table.insert(pattern, "*.yaml")
    end
  end
  return pattern
end

M.getMasonEnsureList = function()
  local cfg = require("insis").config

  -- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
  -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
  local configMap = {
    sumneko_lua = require("insis.lsp.config.lua"), -- lua/lsp/config/lua.lua
    bashls = require("insis.lsp.config.bash"),
    pyright = require("insis.lsp.config.pyright"),
    pylsp = require("insis.lsp.config.pylsp"),
    html = require("insis.lsp.config.html"),
    cssls = require("insis.lsp.config.css"),
    emmet_ls = require("insis.lsp.config.emmet"),
    jsonls = require("insis.lsp.config.json"),
    ruby_ls = require("insis.lsp.config.rubyls"),
    -- DEPRECATE
    -- tsserver = require("insis.lsp.config.ts"),
    tsserver = require("insis.lsp.config.typescript"),
    yamlls = require("insis.lsp.config.yamlls"),
    dockerls = require("insis.lsp.config.docker"),
    tailwindcss = require("insis.lsp.config.tailwindcss"),
    rust_analyzer = require("insis.lsp.config.rust"),
    taplo = require("insis.lsp.config.taplo"), -- toml
    gopls = require("insis.lsp.config.gopls"),
    clangd = require("insis.lsp.config.clangd"),
    cmake = require("insis.lsp.config.cmake"),
    -- remark_ls = require("insis.lsp.config.markdown"),
  }

  -- servers
  -- key : lspconfig server name
  -- vale: my config file
  local servers = {}
  if cfg.frontend and cfg.frontend.enable then
    -- frontend need several lsp servers
    for _, value in pairs(cfg.frontend.lsp) do
      if configMap[value] then
        servers[value] = configMap[value]
      end
    end
  end

  if cfg.clangd and cfg.clangd.enable then
    if configMap[cfg.clangd.lsp] then
      servers[cfg.clangd.lsp] = configMap[cfg.clangd.lsp]
    end
  end

  if cfg.golang and cfg.golang.enable then
    if configMap[cfg.golang.lsp] then
      servers[cfg.golang.lsp] = configMap[cfg.golang.lsp]
    end
  end

  if cfg.lua and cfg.lua.enable then
    if configMap[cfg.lua.lsp] then
      servers[cfg.lua.lsp] = configMap[cfg.lua.lsp]
    end
  end

  if cfg.rust and cfg.rust.enable then
    if configMap[cfg.rust.lsp] then
      servers[cfg.rust.lsp] = configMap[cfg.rust.lsp]
    end
  end

  if cfg.sh and cfg.sh.enable then
    if configMap[cfg.sh.lsp] then
      servers[cfg.sh.lsp] = configMap[cfg.sh.lsp]
    end
  end

  if cfg.python and cfg.python.enable then
    if configMap[cfg.python.lsp] then
      servers[cfg.python.lsp] = configMap[cfg.python.lsp]
    end
  end

  if cfg.ruby and cfg.ruby.enable then
    if configMap[cfg.ruby.lsp] then
      servers[cfg.ruby.lsp] = configMap[cfg.ruby.lsp]
    end
  end

  if cfg.json and cfg.json.enable then
    if configMap[cfg.json.lsp] then
      servers[cfg.json.lsp] = configMap[cfg.json.lsp]
    end
  end

  -- if cfg.markdown and cfg.markdown.enable then
  -- not used
  -- end

  local ensureInstalled = {}
  for key, _ in pairs(servers) do
    table.insert(ensureInstalled, key)
  end

  return ensureInstalled, servers
end

M.getNeotestAdapters = function()
  local cfg = require("insis").config
  local adapters = {}
  if cfg.golang and cfg.golang.enable then
    table.insert(
      adapters,
      pRequire("neotest-go")({
        experimental = {
          test_table = true,
        },
        args = { "-count=1", "-timeout=60s" },
      })
    )
  end
  return adapters
end

return M
