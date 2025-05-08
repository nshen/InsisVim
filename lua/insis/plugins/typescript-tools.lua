local cfg = require("insis").config.frontend
local ts_tools = pRequire("typescript-tools")

if ts_tools and cfg and cfg.enable and not cfg.vue then
  local common = require("insis.lsp.common-config")
  ts_tools.setup({
    capabilities = common.capabilities,
    on_attach = function(client, bufnr)
      if cfg.formatter ~= "ts_ls" then
        common.disableFormat(client)
      end
      common.keyAttach(bufnr)
      if cfg.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        local inlay_hints_group = vim.api.nvim_create_augroup("InlayHints", { clear = true })
        vim.api.nvim_create_autocmd("InsertEnter", {
          group = inlay_hints_group,
          buffer = bufnr,
          callback = function()
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
          end,
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
          group = inlay_hints_group,
          buffer = bufnr,
          callback = function()
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end,
        })
      end
    end,
    settings = {
      expose_as_code_actions = "all",
      jsx_close_tag = {
        enable = false,
        filetypes = { "javascriptreact", "typescriptreact" },
      },
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  })
end
