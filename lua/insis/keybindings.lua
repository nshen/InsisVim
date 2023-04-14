-- For common keybindings -------------------------------

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
---------------------------------------------------------

local cfg = require("insis").config
local keys = cfg.keys

-- leader key
vim.g.mapleader = keys.leader_key
vim.g.maplocalleader = keys.leader_key

-- save && quit
keymap("n", keys.n_save, "<CMD>w<CR>")
keymap("n", keys.n_force_quit, "<CMD>qa!<CR>")
-- keymap("n", keys.n_save_quit, "<CMD>wq<CR>")
-- keymap("n", keys.n_save_all, "<CMD>wa<CR>")
-- keymap("n", keys.n_save_all_quit, "<CMD>wqa<CR>")

-- $ jump to the end without space (swap $ and g_)
keymap({ "v", "n" }, "$", "g_")
keymap({ "v", "n" }, "g_", "$")

keymap({ "n", "v" }, keys.n_v_5j, "5j")
keymap({ "n", "v" }, keys.n_v_5k, "5k")

keymap({ "n", "v" }, keys.n_v_10j, "10j")
keymap({ "n", "v" }, keys.n_v_10k, "10k")

-- very magic search mode
if cfg.enable_very_magic_search then
  keymap({ "n", "v" }, "/", "/\\v", {
    remap = false,
    silent = false,
  })
  keymap("c", "s/", "s/\\v", {
    remap = false,
    silent = false,
  })
end

-------------------- fix ------------------------------

local opts_expr = {
  expr = true,
  silent = true,
}
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

--------------- super window -----------------------

if cfg.s_windows ~= nil and cfg.s_windows.enable then
  local skey = cfg.s_windows.keys
  keymap("n", "s", "")
  keymap("n", skey.split_vertically, ":vsp<CR>")
  keymap("n", skey.split_horizontally, ":sp<CR>")
  keymap("n", skey.close, "<C-w>c")
  keymap("n", skey.close_others, "<C-w>o") -- close others
  keymap("n", skey.jump_left, "<C-w>h")
  keymap("n", skey.jump_down, "<C-w>j")
  keymap("n", skey.jump_up, "<C-w>k")
  keymap("n", skey.jump_right, "<C-w>l")
  keymap("n", skey.width_decrease, ":vertical resize -10<CR>")
  keymap("n", skey.width_increase, ":vertical resize +10<CR>")
  keymap("n", skey.height_decrease, ":horizontal resize -10<CR>")
  keymap("n", skey.height_increase, ":horizontal resize +10<CR>")
  keymap("n", skey.size_equal, "<C-w>=")
end

-------------- super tab ---------------------------

if cfg.s_tab ~= nil and cfg.s_tab.enable then
  local tkey = cfg.s_tab.keys
  keymap("n", tkey.split, "<CMD>tab split<CR>")
  keymap("n", tkey.close, "<CMD>tabclose<CR>")
  keymap("n", tkey.next, "<CMD>tabnext<CR>")
  keymap("n", tkey.prev, "<CMD>tabprev<CR>")
  keymap("n", tkey.first, "<CMD>tabfirst<CR>")
  keymap("n", tkey.last, "<CMD>tablast<CR>")
end

-- treesitter fold
keymap("n", keys.fold.open, ":foldopen<CR>")
keymap("n", keys.fold.close, ":foldclose<CR>")

-- Esc back to Normal mode
keymap("t", keys.terminal_to_normal, "<C-\\><C-n>")

-- DEPRECATED :Terminal kes

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
