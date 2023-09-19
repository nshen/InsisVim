local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local M = {}
M.avaliable = function()
  return vim.loop.fs_stat(lazypath)
end

M.install = function()
  vim.notify("Installing plugin manager lazy.nvim ...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  vim.notify("plugin manager installed complete")
end

M.setup = function()
  vim.opt.rtp:prepend(lazypath)
  local status_ok, lazy = pcall(require, "lazy")
  if not status_ok then
    vim.notify("require lazy.nvim")
    return
  end
  local plugins = require("insis.plugins")
  lazy.setup(plugins)
end

return M
