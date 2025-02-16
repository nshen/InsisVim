--- @param config InsisRubyConfig
return function(config)
  return {

    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.rb" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "ruby" }
    end,

    getLSPEnsureList = function()
      return { "ruby_ls" }
    end,

    getLSPConfigMap = function()
      return {
        ruby_ls = require("insis.lsp.config.rubyls"),
      }
    end,

    getToolEnsureList = function()
      if config.formatter == "rubocop" then
        return { "rubocop" }
      end
      return {}
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.formatter == "rubocop" then
        return { null_ls.builtins.formatting.rubocop }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
