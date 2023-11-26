local M = {}
M.version = "v0.10.2"

---@type UserConfig
M.config = require("insis.config")
--- @param user_config UserConfig
function M.setup(user_config)
  require("insis.utils.global")
  require("insis.basic")
  -- user config override
  M.config = vim.tbl_deep_extend("force", M.config, user_config)
  require("insis.env").init(M.config)
  require("insis.keybindings")
  local pluginManager = require("insis.lazy")
  if not pluginManager.avaliable() then
    pluginManager.install()
  end
  pluginManager.setup()
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
