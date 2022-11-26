vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
-- jkhl padding
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- use relative number
vim.wo.number = true
vim.wo.relativenumber = true
-- highlight current row /column
vim.wo.cursorline = true
vim.wo.cursorcolumn = false
-- left sign column
vim.wo.signcolumn = "yes"
-- line of reference on right
-- vim.wo.colorcolumn = "80"
-- 2 space = 1 tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << move
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- space instead tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- copy indent from current line when starting a new line
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- ignore case except uppercase
vim.o.ignorecase = true
vim.o.smartcase = true
-- search hight
vim.opt.hlsearch = false
vim.o.incsearch = true
vim.o.cmdheight = 1
-- auto load when file edit outside
vim.o.autoread = true
vim.bo.autoread = true
-- no wrap for code
vim.wo.wrap = false
vim.o.whichwrap = "<,>,[,]"
vim.o.hidden = true
vim.o.mouse = "a"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- smaller updatetime
vim.o.updatetime = 500
-- Time in milliseconds to wait for a mapped sequence to complete.
vim.o.timeoutlen = 500
-- split window right and below
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.termguicolors = true
vim.opt.termguicolors = true
-- invisible chars display
vim.o.list = false
vim.o.listchars = "space:·,tab:··"
-- cmp
vim.g.completeopt = "menu,menuone,noselect,noinsert"
--command-line completion is enhanced
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"
-- popup menu 10 items in max
vim.o.pumheight = 10
-- always display tabline
vim.o.showtabline = 2
-- use lualine plugin instead
vim.o.showmode = false
-- system clipboard
vim.opt.clipboard = "unnamedplus"
-- disable netrw at the very start of your init.lua (strongly advised) nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
