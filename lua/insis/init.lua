local M = {}

M.config = require("insis.config")

function M.setup(user_config)
  require("insis.utils.global")

  -- user config override
  M.config = vim.tbl_deep_extend("force", M.config, user_config)
  -- log(M.config)

  -- check packer.nvim exists
  local packer = require("insis.packer")
  if not packer.avaliable() then
    vim.notify("please use install script to install insisVim")
    -- packer.install()
    return
  end

  packer.setup()

  -- pRequire("impatient")
  require("insis.basic")
  require("insis.keybindings")
  require("insis.colorscheme")
  require("insis.autocmds")
  require("insis.lsp")
  require("insis.cmp")
  require("insis.format")
  require("insis.dap")
  require("insis.utils.change-colorscheme")
  -- require('utils.fix-yank')
end

return M
