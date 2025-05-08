return {
  ---@diagnostic disable-next-line: unused-local
  on_setup = function(server)
    local util = require("lspconfig.util")
    vim.lsp.config("biome", {
      cmd = { "biome", "lsp-proxy" },
      filetypes = {
        "astro",
        "css",
        "graphql",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "svelte",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "vue",
      },
      workspace_required = true,
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root_files = { "biome.json", "biome.jsonc" }
        root_files = util.insert_package_json(root_files, "biome", fname)
        local root_dir = vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1])
        on_dir(root_dir)
      end,
    })
    vim.lsp.enable("biome")
  end,
}
