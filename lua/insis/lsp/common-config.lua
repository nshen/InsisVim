local M = {}

M.keyAttach = function(bufnr)
  local lsp = require("insis").config.lsp
  local opt = { noremap = true, silent = true, buffer = bufnr }

  -- TODO: move to config.diagnostic
  -- diagnostic
  keymap("n", lsp.open_flow, "<CMD>lua vim.diagnostic.open_float()<CR>")
  keymap("n", lsp.goto_next, "<CMD>lua vim.diagnostic.goto_next()<CR>")
  keymap("n", lsp.goto_prev, "<CMD>lua vim.diagnostic.goto_prev()<CR>")
  keymap("n", lsp.list, "<CMD>lua Telescope loclist<CR>")

  -- lsp
  keymap("n", lsp.definition, require("telescope.builtin").lsp_definitions, opt)
  keymap("n", lsp.declaration, vim.lsp.buf.declaration, opt)
  keymap("n", lsp.hover, vim.lsp.buf.hover, opt)
  keymap("n", lsp.implementation, require("telescope.builtin").lsp_implementations, opt)
  keymap(
    "n",
    lsp.references,
    "<CMD>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_ivy())<CR>",
    opt
  )

  keymap("n", lsp.rename, "<CMD>lua vim.lsp.buf.rename()<CR>", opt)
  keymap("n", lsp.code_action, "<CMD>lua vim.lsp.buf.code_action()<CR>", opt)
  keymap("n", lsp.format, "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", opt)

  -- not used
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
end

-- 禁用格式化功能，交给专门插件插件处理
M.disableFormat = function(client)
  if vim.fn.has("nvim-0.8") == 1 then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

-- M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

M.flags = {
  debounce_text_changes = 150,
}

return M
