return {
  on_setup = function(_)
    -- Do not call the nvim-lspconfig.rust_analyzer setup or set up the LSP client for rust-analyzer manually,
    -- as doing so may cause conflicts.
    local cfg = require("insis").config
    local common = require("insis.lsp.common-config")
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {},
      -- LSP configuration
      server = {
        on_attach = function(_, bufnr)
          common.keyAttach(bufnr)
          local opt = { noremap = true, silent = true, buffer = bufnr }

          ---@diagnostic disable-next-line: need-check-nil
          keymap("n", cfg.lsp.hover, function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, opt)

          ---@diagnostic disable-next-line: need-check-nil
          keymap("n", cfg.lsp.code_action, function()
            vim.cmd.RustLsp("codeAction")
          end, opt)

          keymap("n", cfg.rust.keys.explain_error, function()
            vim.cmd.RustLsp("explainError", "current")
          end, opt)
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {},
        },
      },
      -- DAP configuration
      dap = {},
    }
  end,
}
