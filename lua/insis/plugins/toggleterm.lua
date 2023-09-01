local toggleterm = pRequire("toggleterm")
local cfg = require("insis").config.toggleterm

if toggleterm and cfg and cfg.enable then
  local on_open_common = function(term)
    vim.cmd("startinsert!")
    -- q / <leader>tg will close terminal
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>tg", "<cmd>close<CR>", { noremap = true, silent = true })
  end

  toggleterm.setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.3
      end
    end,
    start_in_insert = true,
  })

  local Terminal = require("toggleterm.terminal").Terminal

  local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    on_open = function(term)
      on_open_common(term)
      -- delete ESC key for lazygit
      if vim.fn.mapcheck("<Esc>", "t") ~= "" then
        vim.api.nvim_del_keymap("t", "<Esc>")
      end
    end,
    on_close = function(_)
      --  add ESC back
      vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
        noremap = true,
        silent = true,
      })
    end,
  })

  local ta = Terminal:new({
    direction = "float",
    float_opts = {
      border = "rounded",
    },
    close_on_exit = true,
    on_open = on_open_common,
  })

  local tb = Terminal:new({
    direction = "vertical",
    close_on_exit = true,
    on_open = on_open_common,
  })

  local tc = Terminal:new({
    direction = "horizontal",
    close_on_exit = true,
    on_open = on_open_common,
  })

  local M = {}

  M.toggleA = function(cmd)
    if ta:is_open() then
      ta:close()
      return
    end
    tb:close()
    tc:close()
    ta:open()
    if cmd ~= nil then
      ta:send(cmd)
    end
  end

  M.toggleB = function(cmd)
    if tb:is_open() then
      tb:close()
      return
    end
    ta:close()
    tc:close()
    tb:open()
    if cmd ~= nil then
      tb:send(cmd)
    end
  end

  M.toggleC = function(cmd)
    if tc:is_open() then
      tc:close()
      return
    end
    ta:close()
    tb:close()
    tc:open()
    if cmd ~= nil then
      tc:send(cmd)
    end
  end

  M.toggleG = function()
    lazygit:toggle()
  end

  vim.keymap.set({ "n", "t" }, cfg.toggle_float_window, function()
    M.toggleA(cfg.toggle_float_window_command)
  end)
  vim.keymap.set({ "n", "t" }, cfg.toggle_side_window, function()
    M.toggleB(cfg.toggle_side_window_command)
  end)
  vim.keymap.set({ "n", "t" }, cfg.toggle_bottom_window, function()
    M.toggleC(cfg.toggle_bottom_window_command)
  end)
end
