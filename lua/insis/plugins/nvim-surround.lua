local surround = pRequire("nvim-surround")
local cfg = require("insis").config.surround

if surround and cfg and cfg.enable then
  surround.setup({
    keymaps = vim.tbl_deep_extend("force", {
      -- you surround
      normal = "ys",
      -- you surround line
      normal_cur = "yss",

      delete = "ds",
      change = "cs",

      visual = "s",
      visual_line = "gs",

      insert = false,
      insert_line = false,
      -- you surround with delimiter
      normal_line = false,
      -- you surround line with delimiter
      normal_cur_line = false,
    }, cfg.keys),
  })
end
