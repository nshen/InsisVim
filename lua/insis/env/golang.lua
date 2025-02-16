--- @param config InsisGolangConfig
return function(config)
  return {

    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.go" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "go" }
    end,

    getLSPEnsureList = function()
      return { "gopls" }
    end,

    getLSPConfigMap = function()
      return {
        gopls = require("insis.lsp.config.gopls"),
      }
    end,

    getToolEnsureList = function()
      if config.linter == "golangci-lint" then
        return { "golangci-lint" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.formatter == "gofmt" then
        return { null_ls.builtins.formatting.gofmt }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {
        pRequire("neotest-go")({
          experimental = {
            test_table = true,
          },
          args = { "-count=1", "-timeout=60s" },
        }),
      }
    end,
  }
end
