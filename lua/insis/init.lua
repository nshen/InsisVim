local M = {}
M.version = "v0.11.2"

--- @type InsisUserConfig
M.config = require("insis.config")
--- @param user_config InsisUserConfig
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
  require("insis.colorscheme").reset()
  require("insis.autocmds")
  require("insis.lsp")
  require("insis.cmp")
  require("insis.format")
  require("insis.dap")
  require("insis.utils.color-preview")
  if M.config.fix_windows_clipboard then
    require("utils.fix-yank")
  end
end

return M
