local p = require("insis.utils.path")
local cfg = require("insis").config

local function createSnapshots()
  vim.api.nvim_command("PackerSnapshot snapshots-" .. require("insis").version .. ".json")
end

vim.api.nvim_create_user_command("InsisCreateSnapshots", createSnapshots, {})

local function readSnapshotJSON()
  local snapshotPath = p.join(p.getConfig(), "snapshots-" .. require("insis").version .. ".json")
  return vim.fn.json_decode(vim.fn.readfile(snapshotPath))
end


local M = {}

M.getPluginList = function()
  local status_ok, snapshot = pcall(readSnapshotJSON)
  if not status_ok then
    log("ERROR: read " .. "snapshots-" .. require("insis").version .. ".json failed!")
  end
  package.loaded["insis.plugins"] = nil
  local pluginList = require("insis.plugins")
  if cfg.lock_plugin_commit then
    for _, plugin in ipairs(pluginList) do
      local short_name, _ = require("packer.util").get_plugin_short_name(plugin)
      if snapshot and snapshot[short_name] and snapshot[short_name].commit then
        plugin.commit = snapshot[short_name].commit
      end
    end
  end
  return pluginList
end

return M
