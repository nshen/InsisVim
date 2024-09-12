local typescript = pRequire("typescript")
local cfg = require("insis").config.frontend

if typescript and cfg and cfg.enable then
  local common = require("insis.lsp.common-config")
  local opts = {
    capabilities = common.capabilities,
    flags = common.flags,
    on_attach = function(client, bufnr)
      if cfg.formatter ~= "ts_ls" then
        common.disableFormat(client)
      end
      common.keyAttach(bufnr)

      --[[ 
        :TypescriptOrganizeImports
        :TypescriptRenameFile
        :TypescriptAddMissingImports
        :TypescriptRemoveUnused
        :TypescriptFixAll
        :TypescriptGoToSourceDefinition 
    ]]

      -- local bufopts = { noremap = true, silent = true, buffer = bufnr }
      -- keymap("n", cfg.typescript.keys.ts_organize, ":TypescriptOrganizeImports<CR>", bufopts)
      -- keymap("n", cfg.typescript.keys.ts_rename_file, ":TypescriptRenameFile<CR>", bufopts)
      -- keymap("n", cfg.typescript.keys.ts_add_missing_import, ":TypescriptAddMissingImports<CR>", bufopts)
      -- keymap("n", cfg.typescript.keys.ts_remove_unused, ":TypescriptRemoveUnused<CR>", bufopts)
      -- keymap("n", cfg.typescript.keys.ts_fix_all, ":TypescriptFixAll<CR>", bufopts)
      -- keymap("n", cfg.typescript.keys.ts_goto_source, ":TypescriptGoToSourceDefinition<CR>", bufopts)
    end,
  }
  return {
    on_setup = function(_)
      typescript.setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true, -- fall back to standard LSP definition on failure
        },
        -- pass options to lspconfig's setup method
        server = opts,
      })
    end,
  }
end
