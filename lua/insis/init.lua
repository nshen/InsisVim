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
  -- 基础配置
  require("insis.basic")
  -- 快捷键映射
  require("insis.keybindings")
  -- 主题设置
  require("insis.colorscheme")
  -- 自动命令
  require("insis.autocmds")
  -- 内置LSP
  require("insis.lsp")
  -- 自动补全
  require("insis.cmp")
  -- 格式化
  require("insis.format")
  -- DAP
  require("insis.dap")
  -- 复制到windows剪贴板
  -- require('utils.fix-yank')
end

return M
