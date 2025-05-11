-- based on https://github.com/antfu/eslint-config

local customizations = {
  { rule = "style/*", severity = "off", fixable = true },
  { rule = "format/*", severity = "off", fixable = true },
  { rule = "*-indent", severity = "off", fixable = true },
  { rule = "*-spacing", severity = "off", fixable = true },
  { rule = "*-spaces", severity = "off", fixable = true },
  { rule = "*-order", severity = "off", fixable = true },
  { rule = "*-dangle", severity = "off", fixable = true },
  { rule = "*-newline", severity = "off", fixable = true },
  { rule = "*quotes", severity = "off", fixable = true },
  { rule = "*semi", severity = "off", fixable = true },
}
return {
  on_setup = function(server)
    server.setup({
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "html",
        "markdown",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "xml",
        "gql",
        "graphql",
        "astro",
        "svelte",
        "css",
        "less",
        "scss",
        "pcss",
        "postcss",
      },
      settings = {
        -- Silent the stylistic rules in you IDE, but still auto fix them
        rulesCustomizations = customizations,
      },
      ---@diagnostic disable-next-line: unused-local
      on_attach = function(_client, bufnr)
        local cfg = require("insis").config
        if cfg.formatter == "eslint" and cfg.linter == "eslint" then
          -- format keymap
          local opt = { noremap = true, silent = true, buffer = bufnr }
          keymap("n", cfg.lsp.format, function()
            vim.cmd("EslintFixAll")
          end, opt)

          -- format on save
          if cfg.frontend.format_on_save then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end
        end
      end,
    })
  end,
}
