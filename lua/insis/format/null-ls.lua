local null_ls = pRequire("null-ls")

if not null_ls then
  return
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
  prettier = formatting.prettier.with({ -- 比默认少了 markdown
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
      "json",
      "yaml",
      "graphql",
      "markdown",
    },
    timeout = 10000,
    -- prefer_local = "node_modules/.bin",
    only_local = "node_modules/.bin",
  }),
  black = formatting.black.with({ extra_args = { "--fast" } }),
  rubocop = formatting.rubocop,
  fixjson = formatting.fixjson,
}

local linterMap = {
  golangci_lint = diagnostics.golangci_lint,
  eslint_d = diagnostics.eslint_d,
}

-- add sources based on config file
local sources = {}

if cfg.git and cfg.git.enable then
  table.insert(sources, code_actions.gitsigns)
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

if cfg.frontend and cfg.frontend.enable then
  local formatter = formatterMap[cfg.frontend.formatter]
  local linter = linterMap[cfg.frontend.linter]
  if formatter then
    table.insert(sources, formatter)
  end
  if linter then
    table.insert(sources, linter)
  end
  if cfg.frontend.code_actions == "eslint_d" then
    table.insert(sources, code_actions.eslint_d)
  end
end

if cfg.lua and cfg.lua.enable then
  local formatter = formatterMap[cfg.lua.formatter]
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

if cfg.rust and cfg.rust.enable then
  local formatter = formatterMap[cfg.rust.formatter]
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
  local formatter = formatterMap[cfg.json.formatter]
  if formatter then
    table.insert(sources, formatter)
  end
end
null_ls.setup({
  debug = false,
  sources = sources,
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",
  on_attach = function(_)
    -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    -- end
  end,
})
