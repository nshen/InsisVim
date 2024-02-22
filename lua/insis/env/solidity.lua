-- Solidity snippets
-- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/solidity.json
--- @param config SolidityConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.sol" }
      end
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
      if config.enable then
        return {
          solidity = require("insis.lsp.config.solidity"), -- lua/lsp/config/solidity.lua
        }
      end
      return {}
    end,

    getToolEnsureList = function()
      if config.linter == "solhint" then
        return { "solhint" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.linter == "solhint" then
        log(11)
        return { null_ls.builtins.diagnostics.solhint }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
