local cmp = require("insis").config.cmp
if not cmp then
  return
end

local M = {}
M.init = function()
  local codeium = pRequire("codeium")
  if codeium and cmp.codeium then
    require("codeium").setup({
      enable_chat = true,
    })
  end
end

return M
