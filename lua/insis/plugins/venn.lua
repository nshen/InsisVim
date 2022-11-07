local cfg = require("insis").config.venn

if cfg and cfg.enable then
  vim.keymap.set("n", cfg.keys.toggle, function()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
      vim.b.venn_enabled = true
      vim.cmd([[setlocal ve=all]])
      -- draw a line on HJKL keystokes
      vim.api.nvim_buf_set_keymap(0, "n", cfg.keys.down, "<C-v>j:VBox<CR>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", cfg.keys.up, "<C-v>k:VBox<CR>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", cfg.keys.right, "<C-v>l:VBox<CR>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "n", cfg.keys.left, "<C-v>h:VBox<CR>", { noremap = true })
      vim.api.nvim_buf_set_keymap(0, "v", cfg.keys.draw_box, ":VBox<CR>", { noremap = true })
      print("-- venn mode --")
    else
      vim.cmd([[setlocal ve=]])
      vim.cmd([[mapclear <buffer>]])
      print(" ")
      print(" ")
      vim.cmd([[messages clear]])
      vim.b.venn_enabled = nil
    end
  end, { noremap = true, silent = true })
end
