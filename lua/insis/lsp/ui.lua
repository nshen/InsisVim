vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  show_header = false,
  severity_sort = true,
  float = {
    source = true,
    border = "rounded",
    style = "minimal",
    header = "",
    -- prefix = " ",
    -- max_width = 100,
    -- width = 60,
    -- height = 20,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ✘", --" ", ""
      [vim.diagnostic.severity.WARN] = " ", -- " "
      [vim.diagnostic.severity.HINT] = " 󰌶", -- "󰌵 "
      [vim.diagnostic.severity.INFO] = " ", -- "󰋼 "
    },
  },
})
