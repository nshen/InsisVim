local cfg = require("insis").config
local keys = cfg.keys

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- 本地变量
local map = vim.api.nvim_set_keymap

local opt = {
  noremap = true,
  silent = true,
}
--------------------------------------------------------------------------

-- leader key 为空
vim.g.mapleader = keys.leader_key
vim.g.maplocalleader = keys.leader_key

local opts_expr = {
  expr = true,
  silent = true,
}


-- save && quit
keymap("n", keys.n_save, "<CMD>w<CR>")
keymap("n", keys.n_save_quit, "<CMD>wq<CR>")
keymap("n", keys.n_save_all, "<CMD>wa<CR>")
keymap("n", keys.n_save_all_quit, "<CMD>wqa<CR>")
keymap("n", keys.n_force_quit, "<CMD>qa!<CR>")

-- $跳到行尾不带空格 (交换$ 和 g_)
keymap({ "v", "n" }, "$", "g_")
keymap({ "v", "n" }, "g_", "$")

-- 上下滚动浏览
keymap({ "n", "v" }, keys.n_v_5j, "5j")
keymap({ "n", "v" }, keys.n_v_5k, "5k")

-- ctrl u / ctrl + d  只移动9行，默认移动半屏
-- keymap({ "n", "v" }, keys.n_v_10j, "10j")
-- keymap({ "n", "v" }, keys.n_v_10k, "10k")

-- magic search
if cfg.enable_magic_search then
  keymap({ "n", "v" }, "/", "/\\v", {
    remap = false,
    silent = false,
  })
else
  keymap({ "n", "v" }, "/", "/", {
    remap = false,
    silent = false,
  })
end

-------------------- fix ------------------------------

-- fix :set wrap
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", opts_expr)
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", opts_expr)

-- visual模式下缩进代码
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- 上下移动选中文本
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")

-- 在visual mode 里粘贴不要复制
keymap("x", "p", '"_dP')

if cfg.s_windows ~= nil and cfg.s_windows.enable then
  local skey = cfg.s_windows.keys
  -- 取消 s 默认功能
  keymap("n", "s", "")
  keymap("n", skey.split_vertically, ":vsp<CR>")
  keymap("n", skey.split_horizontally, ":sp<CR>")
  -- 关闭当前
  keymap("n", skey.close, "<C-w>c")
  -- 关闭其他
  keymap("n", skey.close_others, "<C-w>o") -- close others
  -- alt + hjkl  窗口之间跳转
  keymap("n", skey.jump_left, "<C-w>h")
  keymap("n", skey.jump_down, "<C-w>j")
  keymap("n", skey.jump_up, "<C-w>k")
  keymap("n", skey.jump_right, "<C-w>l")
  -- 比例控制
  keymap("n", skey.width_decrease, ":vertical resize -10<CR>")
  keymap("n", skey.width_increase, ":vertical resize +10<CR>")
  keymap("n", skey.height_decrease, ":vertical resize -10<CR>")
  keymap("n", skey.height_increase, ":vertical resize +10<CR>")
  keymap("n", skey.size_equal, "<C-w>=")
end

if cfg.s_tab ~= nil and cfg.s_tab.enable then
  local tkey = cfg.s_tab.keys
  keymap("n", tkey.split, "<CMD>tab split<CR>")
  keymap("n", tkey.close, "<CMD>tabclose<CR>")
  keymap("n", tkey.next, "<CMD>tabnext<CR>")
  keymap("n", tkey.prev, "<CMD>tabprev<CR>")
  keymap("n", tkey.first, "<CMD>tabfirst<CR>")
  keymap("n", tkey.last, "<CMD>tablast<CR>")
end

-- treesitter 折叠
keymap("n", keys.fold.open, ":foldopen<CR>")
keymap("n", keys.fold.close, ":foldclose<CR>")

-- Esc 回 Normal 模式
keymap("t", keys.terminal_to_normal, "<C-\\><C-n>")
-- Terminal相关
-- map("n", "st", ":sp | terminal<CR>", opt)
-- map("n", "stv", ":vsp | terminal<CR>", opt)
-- map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
-- map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)

--------------------------------------------------------------------
-- 插件快捷键
local pluginKeys = {}

-- nvim-dap
pluginKeys.mapDAP = function()
  -- 开始
  map("n", "<leader>dd", ":RustDebuggables<CR>", opt)
  -- 结束
  map(
    "n",
    "<leader>de",
    ":lua require'dap'.close()<CR>"
      .. ":lua require'dap'.terminate()<CR>"
      .. ":lua require'dap.repl'.close()<CR>"
      .. ":lua require'dapui'.close()<CR>"
      .. ":lua require('dap').clear_breakpoints()<CR>"
      .. "<C-w>o<CR>",
    opt
  )
  -- 继续
  map("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opt)
  -- 设置断点
  map("n", "<leader>dt", ":lua require('dap').toggle_breakpoint()<CR>", opt)
  map("n", "<leader>dT", ":lua require('dap').clear_breakpoints()<CR>", opt)
  --  stepOver, stepOut, stepInto
  map("n", "<leader>dj", ":lua require'dap'.step_over()<CR>", opt)
  map("n", "<leader>dk", ":lua require'dap'.step_out()<CR>", opt)
  map("n", "<leader>dl", ":lua require'dap'.step_into()<CR>", opt)
  -- 弹窗
  map("n", "<leader>dh", ":lua require'dapui'.eval()<CR>", opt)
end

-- vimspector
pluginKeys.mapVimspector = function()
  -- 开始
  map("n", "<leader>dd", ":call vimspector#Launch()<CR>", opt)
  -- 结束
  map("n", "<Leader>de", ":call vimspector#Reset()<CR>", opt)
  -- 继续
  map("n", "<Leader>dc", ":call vimspector#Continue()<CR>", opt)
  -- 设置断点
  map("n", "<Leader>dt", ":call vimspector#ToggleBreakpoint()<CR>", opt)
  map("n", "<Leader>dT", ":call vimspector#ClearBreakpoints()<CR>", opt)
  --  stepOver, stepOut, stepInto
  map("n", "<leader>dj", "<Plug>VimspectorStepOver", opt)
  map("n", "<leader>dk", "<Plug>VimspectorStepOut", opt)
  map("n", "<leader>dl", "<Plug>VimspectorStepInto", opt)
end

return pluginKeys
