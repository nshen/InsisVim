local cfg = require("insis").config.frontend
local ts_tools = pRequire("typescript-tools")

if ts_tools and cfg and cfg.enable and not cfg.vue then
  local common = require("insis.lsp.common-config")
  ts_tools.setup({
    capabilities = common.capabilities,
    on_attach = function(client, bufnr)
      if cfg.formatter ~= "ts_ls" then
        common.disableFormat(client)
        log("disable formatter")
      end
      common.keyAttach(bufnr)
    end,
    settings = {
      expose_as_code_actions = "all",
      jsx_close_tag = {
        enable = true,
        filetypes = { "javascriptreact", "typescriptreact" },
      },
    },
  })
end
