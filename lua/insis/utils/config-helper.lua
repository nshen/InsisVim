local M = {}

-- add sources based on config file
M.getNulllsSources = function()
  local null_ls = pRequire("null-ls")
  if not null_ls then
    return nil
  end

  local cfg = require("insis").config
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
      table.insert(sources, require("typescript.extensions.null-ls.code-actions"))
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

  if cfg.markdown and cfg.markdown.enable then
    if cfg.markdown.formatter == "prettier" then
      table.insert(
        sources,
        formatting.prettier.with({
          filetypes = { "markdown" },
        })
      )
      -- because we didn't use markdown language server, so we have to keymap here
      keymap("n", cfg.lsp.format, vim.lsp.buf.format)
      -- vim.keymap.set("v", "<Leader>1f", vim.lsp.buf.format)
    end
  end
  return sources
end

M.getFormatOnSavePattern = function()
  local cfg = require("insis").config
  local pattern = {}
  if cfg.frontend and cfg.frontend.enable then
    if cfg.frontend.format_on_save then
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
  if cfg.bash and cfg.bash.enable then
    if cfg.bash.format_on_save then
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
  -- toml
  if cfg.yaml and cfg.yaml.enable then
    if cfg.yaml.format_on_save then
      table.insert(pattern, "*.yaml")
    end
  end

  -- markdown
  if cfg.markdown and cfg.markdown.enable then
    if cfg.markdown.format_on_save then
      table.insert(pattern, "*.md")
      table.insert(pattern, "*.mdx")
    end
  end
  log(pattern)
  return pattern
end

M.getMasonConfig = function()
  local cfg = require("insis").config
  -- all supported lsp server for now
  -- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
  -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
  local configMap = {
    lua_ls = require("insis.lsp.config.lua"), -- lua/lsp/config/lua.lua
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

  -- enabled lsp server map
  -- key : lspconfig server name
  -- vale: lsp config file
  local servers = {}
  -- linter and formatter ensure list
  local toolList = {}

  local ensureTool = function(tool)
    if table.indexOf(toolList, tool) == -1 then
      table.insert(toolList, tool)
    end
  end

  if cfg.lua and cfg.lua.enable then
    if configMap[cfg.lua.lsp] then
      -- lua_ls
      servers[cfg.lua.lsp] = configMap[cfg.lua.lsp]
    end
    if cfg.lua.formatter == "stylua" then
      ensureTool("stylua")
    end
  end

  if cfg.frontend and cfg.frontend.enable then
    -- frontend need several lsp servers
    for _, value in pairs(cfg.frontend.lsp) do
      if configMap[value] then
        servers[value] = configMap[value]
      end
    end
    if cfg.frontend.linter == "eslint_d" or cfg.frontend.formatter == "eslint_d" then
      ensureTool("eslint_d")
    end
    if cfg.frontend.formatter == "prettier" then
      ensureTool("prettier")
    end
  end

  if cfg.clangd and cfg.clangd.enable then
    if configMap[cfg.clangd.lsp] then
      servers[cfg.clangd.lsp] = configMap[cfg.clangd.lsp]
    end
    -- TODO: linter
    if cfg.clangd.formatter == "clang-format" then
      ensureTool("clang-format")
    end
  end

  if cfg.golang and cfg.golang.enable then
    if configMap[cfg.golang.lsp] then
      servers[cfg.golang.lsp] = configMap[cfg.golang.lsp]
    end
    if cfg.golang.linter == "golangci-lint" then
      ensureTool("golangci-lint")
    end
  end

  if cfg.rust and cfg.rust.enable then
    if configMap[cfg.rust.lsp] then
      servers[cfg.rust.lsp] = configMap[cfg.rust.lsp]
    end
    if cfg.rust.formatter == "rustfmt" then
      ensureTool("rustfmt")
    end
  end

  if cfg.sh and cfg.sh.enable then
    if configMap[cfg.sh.lsp] then
      servers[cfg.sh.lsp] = configMap[cfg.sh.lsp]
    end
    if cfg.sh.formatter == "shfmt" then
      ensureTool("shfmt")
    end
  end

  if cfg.python and cfg.python.enable then
    if configMap[cfg.python.lsp] then
      servers[cfg.python.lsp] = configMap[cfg.python.lsp]
    end
    if cfg.python.formatter == "black" then
      ensureTool("black")
    end
  end

  if cfg.ruby and cfg.ruby.enable then
    if configMap[cfg.ruby.lsp] then
      servers[cfg.ruby.lsp] = configMap[cfg.ruby.lsp]
    end
    if cfg.ruby.formatter == "rubocop" then
      ensureTool("rubocop")
    end
  end

  if cfg.json and cfg.json.enable then
    if configMap[cfg.json.lsp] then
      servers[cfg.json.lsp] = configMap[cfg.json.lsp]
    end
    if cfg.json.formatter == "fixjson" then
      ensureTool("fixjson")
    elseif cfg.json.formatter == "prettier" then
      ensureTool("prettier")
    end
  end

  if cfg.markdown and cfg.markdown.enable then
    if cfg.markdown.formatter == "prettier" then
      ensureTool("prettier")
    end
  end

  -- mason lsp ensure list
  local lspList = {}
  for key, _ in pairs(servers) do
    table.insert(lspList, key)
  end
  -- log(servers)
  return lspList, servers, toolList
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
