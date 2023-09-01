local luasnip = pRequire("luasnip")
local types = pRequire("luasnip.util.types")
local cfg = pRequire("insis").config.cmp

local pathUtils = require("insis.utils.path")

if not luasnip or not types then
  return
end

-- custom snippets
pRequire("luasnip.loaders.from_lua").load({
  paths = pathUtils.join(pathUtils.getConfig(), "lua", "insis", "cmp", "snippets", "lua"),
})
pRequire("luasnip.loaders.from_vscode").lazy_load({
  paths = pathUtils.join(pathUtils.getConfig(), "lua", "insis", "cmp", "snippets", "vscode"),
})
-- https://github.com/rafamadriz/friendly-snippets/
pRequire("luasnip.loaders.from_vscode").lazy_load()

luasnip.config.set_config({
  history = true,
  update_events = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        -- virt_text = { { "choiceNode", "Comment" } },
        virt_text = { { "<--", "Error" } },
      },
    },
  },
})

keymap({ "i", "s" }, cfg.keys.snip_jump_next, function()
  if luasnip.jumpable(1) then
    luasnip.jump(1)
  end
end)

keymap({ "i", "s" }, cfg.keys.snip_jump_prev, function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end)

keymap({ "i", "s" }, cfg.keys.snip_next_choice, function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

keymap({ "i", "s" }, cfg.keys.snip_prev_choice, function()
  if luasnip.choice_active() then
    luasnip.change_choice(-1)
  end
end)
