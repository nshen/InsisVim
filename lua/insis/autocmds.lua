local cfg = require("insis").config
local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

if cfg.enable_imselect then
  autocmd("InsertLeave", {
    group = myAutoGroup,
    callback = require("insis.utils.im-select").insertLeave,
  })

  autocmd("InsertEnter", {
    group = myAutoGroup,
    callback = require("insis.utils.im-select").insertEnter,
  })
end

-- auto insert mode when TermOpen
autocmd("TermOpen", {
  group = myAutoGroup,
  command = "startinsert",
})

-- format on save
autocmd("BufWritePre", {
  group = myAutoGroup,
  pattern = require("insis.utils.config-helper").getFormatOnSavePattern(),
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- set wrap only in markdown
autocmd("FileType", {
  group = myAutoGroup,
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- auto run PackerSync when pluginlist is modified
autocmd("BufWritePost", {
  group = myAutoGroup,
  -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
  callback = function()
    if vim.fn.expand("<afile>") == "lua/insis/plugins/init.lua" then
      vim.api.nvim_command("source lua/insis/plugins/init.lua")
      require("insis.packer").setup()
      vim.api.nvim_command("PackerSync")
    end
  end,
})

-- highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = myAutoGroup,
  pattern = "*",
})

-- do not continue comments when type o
autocmd("BufEnter", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
      - "o" -- O and o, don't continue comments
      + "r" -- But do continue when pressing enter.
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "help",
    "man",
    "neotest-output",
  },
  callback = function()
    keymap({ "i", "n" }, { "q", "<esc>" }, "<esc>:close<CR>", { buffer = true })
  end,
})

-- TODO: research treesitter fold problem
-- save fold
local saveable_type = { "*.lua", "*.js", "*.jsx", "*.ts", "*.tsx" }
autocmd("BufWinEnter", {
  group = myAutoGroup,
  pattern = saveable_type,
  command = "silent! loadview",
})

autocmd("BufWrite", {
  group = myAutoGroup,
  pattern = saveable_type,
  command = "mkview",
})
