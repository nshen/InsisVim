local p = require("insis.utils.path")
local uConfig = require("insis").config

local install_path = p.join(p.getData(), "site", "pack", "packer", "start", "packer.nvim")
log(install_path)

local M = {}

M.avaliable = function()
  return vim.fn.empty(vim.fn.glob(install_path)) == 0
end

M.install = function()
  if not M.avaliable() then
    vim.notify("pakcer.nvim installing ...")
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
      install_path,
    })
    -- https://github.com/wbthomason/packer.nvim/issues/750
    local rtp_addition = p.getDataPath() .. "/site/pack/*/start/*"
    if not string.find(vim.o.runtimepath, rtp_addition) then
      vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
    end
    vim.notify("pakcer.nvim install complete")
  end
end

M.setup = function()
  local status_ok, packer = pcall(require, "packer")
  if not status_ok then
    vim.notify("require packer.nvim failed")
    return
  end

  packer.reset()
  packer.startup({
    function(use)
      local snapshotPath = p.join(p.getConfig(), "snapshots", "plugins.json")
      local snapshot = vim.fn.json_decode(vim.fn.readfile(snapshotPath))
      package.loaded["insis.plugins"] = nil
      local pluginList = require("insis.plugins")

      for _, plugin in ipairs(pluginList) do
        local short_name, _ = require("packer.util").get_plugin_short_name(plugin)
        if snapshot and snapshot[short_name] and snapshot[short_name].commit then
          plugin.commit = snapshot[short_name].commit
          use(plugin)
        end
      end
    end,
    config = {
      -- snapshots folder
      snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
      -- snapshot = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots") .. "/v1",
      -- snapshot = "v1",

      max_jobs = 10,
      clone_timeout = 60,
      -- custom source
      git = {
        -- default_url_format = "https://hub.fastgit.xyz/%s",
        -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
        -- default_url_format = "https://gitcode.net/mirrors/%s",
        default_url_format = "https://github.com/%s",
      },
      display = {
        open_fn = function()
          return require("packer.util").float({ border = "rounded" })
        end,
      },
    },
  })

  --[[ packer.init({
    -- snapshots folder
    snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- snapshot = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots") .. "/v1",
    -- snapshot = "v1",

    max_jobs = 10,
    clone_timeout = 60,
    -- custom source
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      default_url_format = "https://github.com/%s",
    },
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  }) ]]
end

M.sync = function()
  local snapshotPath = p.join(p.getConfig(), "snapshots", "plugins.json")
  local snapshot = vim.fn.json_decode(vim.fn.readfile(snapshotPath))

  local status_ok, packer = pcall(require, "packer")
  if not status_ok then
    vim.notify("require packer.nvim failed")
    return
  end

  package.loaded["insis.plugins"] = nil
  local pluginList = require("insis.plugins")
  packer.reset()
  packer.sync()
end

return M
