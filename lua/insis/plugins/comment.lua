local cfg = require("insis").config.comment
local comment = pRequire("Comment")

if comment and cfg and cfg.enable then
  comment.setup({
    mappings = {
      -- disable extra keys
      extra = false,
    },

    -- Normal Mode
    toggler = {
      line = cfg.toggler.line, -- line comment
      block = cfg.toggler.block, -- block comment
    },
    -- Visual Mode
    opleader = {
      line = cfg.opleader.line,
      bock = cfg.opleader.block,
    },

    -- context_commentstring
    -- also see treesitter.lua
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end
