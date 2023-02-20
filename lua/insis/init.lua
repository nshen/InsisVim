local M = {}
M.version = "v0.9.1"

---@type UserConfig
M.config = require("insis.config")

--- @param user_config UserConfig
function M.setup(user_config)
  require("insis.utils.global")
  -- user config override
  M.config = vim.tbl_deep_extend("force", M.config, user_config)
  -- check packer.nvim exists
  local packer = require("insis.packer")
  if not packer.avaliable() then
    -- better to use install script to install insisVim
    packer.install()
    return
  end
  packer.setup()
  require("insis.basic")
  require("insis.keybindings")
  require("insis.autocmds")
  require("insis.lsp")
  require("insis.cmp")
  require("insis.format")
  require("insis.dap")
  require("insis.colorscheme")
  require("insis.utils.color-preview")
  if M.config.fix_windows_clipboard then
    require("utils.fix-yank")
  end
end

return M
