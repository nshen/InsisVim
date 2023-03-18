--- @param config UserConfig
return function(config)
  return {

    getFormatOnSavePattern = function()
      return {}
    end,

    getTSEnsureList = function()
      return {}
    end,

    getLSPEnsureList = function()
      return {}
    end,

    getLSPConfigMap = function()
      return {}
    end,

    getToolEnsureList = function()
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.git.enable and config.git.code_actions == "gitsigns" then
        return {
          null_ls.builtins.code_actions.gitsigns,
        }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
