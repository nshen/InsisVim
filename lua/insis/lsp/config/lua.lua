local cfg = require("insis").config.lua
local common = require("insis.lsp.common-config")

return {
  ---@diagnostic disable-next-line: unused-local
  on_setup = function(_server)
    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
      },
      on_attach = function(client, bufnr)
        common.keyAttach(bufnr)
        if (cfg == nil) then
          return
        end
        if cfg.formatter ~= "lua_ls" then
          common.disableFormat(client)
        end
        if cfg.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end,
      settings = {
        Lua = {
          hint = {
            enable = true, -- necessary
          },
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths
              -- here.
              -- '${3rd}/luv/library'
              -- '${3rd}/busted/library'
            },
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = {
            --   vim.api.nvim_get_runtime_file('', true),
            -- }
          },
        },
      },
    })
    vim.lsp.enable("lua_ls")
  end,
}
