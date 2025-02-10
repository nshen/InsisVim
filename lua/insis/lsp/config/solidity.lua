local common = require("insis.lsp.common-config")
local util = require("lspconfig.util")

local root_files = {
  "foundry.toml",
  "remappings.txt",
  "hardhat.config.js",
  "hardhat.config.ts",
  "truffle.js",
  "truffle-config.js",
  "ape-config.yaml",
}

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    common.keyAttach(bufnr)
    -- common.disableFormat(client)
  end,
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_dir = util.root_pattern(unpack(root_files)) or util.root_pattern(".git", "package.json"),
  single_file_support = true,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
