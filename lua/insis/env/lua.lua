--- @param config LuaConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.lua" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "lua" }
    end,

    getLSPEnsureList = function()
      if config.lsp == "lua_ls" then
        return { "lua_ls" }
      end
      return {}
    end,

    getLSPConfigMap = function()
      if config.lsp == "lua_ls" then
        return {
          lua_ls = require("insis.lsp.config.lua"), -- lua/lsp/config/lua.lua
        }
      end
      return {}
    end,

    getToolEnsureList = function()
      if config.formatter == "stylua" then
        return { "stylua" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.formatter == "stylua" then
        return { null_ls.builtins.formatting.stylua }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
