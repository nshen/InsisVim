--- @param config ClangdConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.c", "*.cpp", "*.cc" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "cpp", "c" }
    end,

    getLSPEnsureList = function()
      return { "clangd" }
    end,

    getLSPConfigMap = function()
      return {
        clangd = require("insis.lsp.config.clangd"),
      }
    end,

    getToolEnsureList = function()
      if config.formatter == "clang-format" then
        return { "clang-format" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.formatter == "clang-format" then
        return { null_ls.builtins.formatting.clang_format }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
