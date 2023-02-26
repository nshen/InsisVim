--- @param config PythonConfig
return function(config)
  return {

    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.py" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "python" }
    end,

    getLSPEnsureList = function()
      if config.lsp == "pylsp" then
        return { "pylsp" }
      end
      return {}
    end,

    getLSPConfigMap = function()
      if config.lsp == "pylsp" then
        return {
          pylsp = require("insis.lsp.config.pylsp"),
        }
      end
      return {}
    end,

    getToolEnsureList = function()
      if config.formatter == "black" then
        return { "black" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.formatter == "black" then
        return { null_ls.builtins.black.with({ extra_args = { "--fast" } }) }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
