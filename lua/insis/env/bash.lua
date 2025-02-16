--- @param config InsisBashConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.sh" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "bash" }
    end,

    getLSPEnsureList = function()
      return { "bashls" }
    end,

    getLSPConfigMap = function()
      return {
        bashls = require("insis.lsp.config.bash"),
      }
    end,

    getToolEnsureList = function()
      if config.formatter == "shfmt" then
        return { "shfmt" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.formatter == "shfmt" then
        return { null_ls.builtins.formatting.shfmt }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
