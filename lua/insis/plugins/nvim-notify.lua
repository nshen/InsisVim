local notify = pRequire("notify")
local cfg = require("insis").config.notify

if notify and cfg and cfg.enable then
  notify.setup({
    stages = cfg.stages,
    timeout = cfg.timeout,
    render = cfg.render,
  })
  vim.notify = notify
end
