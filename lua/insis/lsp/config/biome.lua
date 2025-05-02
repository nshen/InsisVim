return {
  ---@diagnostic disable-next-line: unused-local
  on_setup = function(server)
    -- server.setup({})
    vim.lsp.enable("biome")
    -- vim.lsp.config('biome', {})
  end,
}
