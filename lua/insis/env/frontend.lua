--- @param config FrontendConfig
return function(config)
  return {
    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.ts", "*.tsx", "*.js", "*.jsx" }
      end
      return {}
    end,

    getTSEnsureList = function()
      local list = { "html", "css", "javascript", "typescript", "tsx" }
      if config.prisma then
        table.insert(list, "prisma")
      end
      if config.vue then
        table.insert(list, "vue")
      end
      return list
    end,

    getLSPEnsureList = function()
      local list = { "tsserver", "cssls", "emmet_ls", "html" }
      if config.tailwindcss then
        table.insert(list, "tailwindcss")
      end
      if config.prisma then
        table.insert(list, "prismals")
      end
      if config.vue then
        table.insert(list, "volar")
      end
      return list
    end,

    getLSPConfigMap = function()
      local list = {
        tsserver = require("insis.lsp.config.typescript"),
        cssls = require("insis.lsp.config.css"),
        emmet_ls = require("insis.lsp.config.emmet"),
        html = require("insis.lsp.config.html"),
      }
      if config.tailwindcss then
        list.tailwindcss = require("insis.lsp.config.tailwindcss")
      end
      if config.vue then
        list.volar = require("insis.lsp.config.volar")
      end
      if config.prisma then
        list.prismals = require("insis.lsp.config.prismals")
      end

      return list
    end,

    getToolEnsureList = function()
      local list = {}
      if config.formatter == "eslint_d" or config.linter == "eslint_d" then
        table.insert(list, "eslint_d")
      end
      if config.formatter == "prettier" then
        table.insert(list, "prettier")
      end
      if config.cspell then
        table.insert(list, "cspell")
      end
      return list
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      local list = {}
      if config.formatter == "eslint_d" then
        table.insert(list, null_ls.builtins.formatting.eslint_d)
      elseif config.formatter == "prettier" then
        table.insert(
          list,
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "graphql",
              -- "json",
              -- "yaml",
              -- "markdown",
            },
            timeout = 10000,
            prefer_local = "node_modules/.bin",
          })
        )
      end
      table.insert(list, null_ls.builtins.diagnostics.eslint_d)
      table.insert(list, null_ls.builtins.code_actions.eslint_d)
      table.insert(list, require("typescript.extensions.null-ls.code-actions"))
      if config.cspell then
        table.insert(
          list,
          null_ls.builtins.diagnostics.cspell.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
            },
          })
        )
        table.insert(
          list,
          null_ls.builtins.code_actions.cspell.with({

            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          })
        )
      end
      return list
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
