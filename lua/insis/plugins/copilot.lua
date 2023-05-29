local cmp = require("insis").config.cmp

if cmp.copilot then
  require("copilot").setup()
  require("copilot_cmp").setup()
end
