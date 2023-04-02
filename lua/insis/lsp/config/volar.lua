-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#volar
-- Take Over Mode
local opts = {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
