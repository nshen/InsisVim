--- @param config SolidityConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      return {}
    end,

    getTSEnsureList = function()
      if config.enable then
        return { "solidity" }
      end
      return {}
    end,

    getLSPEnsureList = function()
      if config.enable then
        return { "solidity_ls_nomicfoundation" }
      end
      return {}
    end,

    getLSPConfigMap = function()
      log("solidity")
      if config.enable then
        return {
          solidity = require("insis.lsp.config.solidity"), -- lua/lsp/config/solidity.lua
        }
      end
      return {}
    end,

    getToolEnsureList = function()
      return {}
    end,

    getNulllsSources = function()
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
