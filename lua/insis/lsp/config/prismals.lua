-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#prismals
local util = require("lspconfig.util")
local Path = require("plenary.path")

local root_pattern_func = util.root_pattern("package.json", ".git")
local root_dir = root_pattern_func(vim.fn.getcwd())
local prismaPath = Path:new(root_dir, "node_modules", ".bin", "prisma"):absolute()

local opts = {
  on_attach = function(_, bufnr)
    local lsp = require("insis").config.lsp
    local opt = { noremap = true, silent = true, buffer = bufnr }
    if lsp then
      keymap("n", lsp.format, function()
        vim.lsp.buf.format({ async = true })
      end, opt)
    end
  end,
  settings = {
    prisma = {
      prismaFmtBin = prismaPath,
    },
  },
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
