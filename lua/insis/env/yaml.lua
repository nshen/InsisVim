--- @param config InsisYamlConfig
return function(config)
  return {

    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.yaml" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "yaml" }
    end,

    getLSPEnsureList = function()
      return { "yamlls" }
    end,

    getLSPConfigMap = function()
      return {
        yamlls = require("insis.lsp.config.yamlls"),
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
        return {
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "yaml" },
          }),
        }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
