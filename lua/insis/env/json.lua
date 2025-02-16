--- @param config InsisJsonConfig
return function(config)
  return {

    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.json" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "json" }
    end,

    getLSPEnsureList = function()
      return { "jsonls" }
    end,

    getLSPConfigMap = function()
      return {
        jsonls = require("insis.lsp.config.json"),
      }
    end,

    getToolEnsureList = function()
      if config.formatter == "prettier" then
        return { "prettier" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.formatter == "prettier" then
        return { null_ls.builtins.formatting.prettier.with({
          filetypes = { "json" },
        }) }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
