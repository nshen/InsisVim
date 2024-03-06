local cfg = require("insis").config.json
local common = require("insis.lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    if cfg and cfg.formatter ~= "jsonls" then
      common.disableFormat(client)
    end
    common.keyAttach(bufnr)
  end,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
