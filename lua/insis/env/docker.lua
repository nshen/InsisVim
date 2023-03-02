--- @param config DockerConfig
return function(config)
  return {

    getFormatOnSavePattern = function()
      return {}
    end,

    getTSEnsureList = function()
      return { "dockerfile" }
    end,

    getLSPEnsureList = function()
      if config.lsp == "dockerls" then
        return { "dockerls" }
      end
      return {}
    end,

    getLSPConfigMap = function()
      return {
        dockerls = require("insis.lsp.config.docker"),
      }
    end,

    getToolEnsureList = function()
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
