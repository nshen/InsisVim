--- @param config InsisRustConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.rust" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "rust" }
    end,

    getLSPEnsureList = function()
      return { "rust_analyzer" }
    end,

    getLSPConfigMap = function()
      return {
        rust_analyzer = require("insis.lsp.config.rust"),
      }
    end,

    getToolEnsureList = function()
      -- if config.formatter == "rustfmt" then
      --   return { "rustfmt" }
      -- end
      return {}
    end,

    getNulllsSources = function()
      -- rustaceanvim plugin don't need these
      -- local null_ls = pRequire("null-ls")
      -- if not null_ls then
      --   return {}
      -- end
      -- if config.formatter == "rustfmt" then
      --   return { null_ls.builtins.formatting.rustfmt }
      -- end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
