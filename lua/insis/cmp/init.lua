local cmp = pRequire("cmp")
local luasnip = pRequire("luasnip")
local cfg = require("insis").config.cmp

if not cmp or not luasnip or not cfg or not cfg.enable then
  return
end

local formatting = require("insis.cmp.format").formatting

local mapping = {
  [cfg.keys.complete] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  [cfg.keys.abort] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  -- Accept currently selected item. If none selected, `select` first item.
  -- Set `select` to `false` to only confirm explicitly selected items.
  [cfg.keys.confirm] = cmp.mapping.confirm({
    select = true,
    behavior = cmp.ConfirmBehavior.Replace,
  }),
  [cfg.keys.scroll_doc_up] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  [cfg.keys.scroll_doc_down] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  [cfg.keys.select_prev_item] = cmp.mapping.select_prev_item(),
  [cfg.keys.select_next_item] = cmp.mapping.select_next_item(),
}

-- select next/prev in command mode
keymap("c", cfg.keys.select_next_item, "<C-n>", {
  remap = true,
  silent = true,
})
keymap("c", cfg.keys.select_prev_item, "<C-p>", {
  remap = true,
  silent = true,
})

cmp.setup({
  -- we use luasnip
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = mapping,
  formatting = formatting,
  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
      group_index = 1,
      priority = 1000,
    },
    {
      name = "nvim_lsp_signature_help",
      group_index = 1,
      priority = 1000,
    },
    {
      name = "luasnip",
      group_index = 2,
      priority = 1000,
    },
    { name = "codeium", group_index = 2, priority = 1000 },
    { name = "copilot", group_index = 2, priority = 1000 },
    {
      name = "buffer",
      group_index = 3,
      priority = 500,
    },
    {
      name = "path",
      group_index = 3,
      priority = 300,
    },
  }),
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { {
    name = "buffer",
  } },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ {
    name = "path",
  } }, { {
    name = "cmdline",
  } }),
})

cmp.setup.filetype({ "markdown", "help" }, {
  window = {
    documentation = cmp.config.disable,
  },
  sources = { {
    name = "luasnip",
  }, {
    name = "buffer",
  }, {
    name = "path",
  } },
})

require("insis.cmp.luasnip")
