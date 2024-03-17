--- @param config MarkdownConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.md", "*.mdx" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "markdown", "markdown_inline" }
    end,

    getLSPEnsureList = function()
      return {} -- empty array
    end,

    getLSPConfigMap = function()
      return {}
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
          filetypes = { "markdown" },
        }) }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
