-- Every Env File should implements methods below

-- getFormatOnSavePattern
-- getTSEnsureList
-- getLSPEnsureList
-- getLSPConfigMap
-- getToolEnsureList
-- getNulllsSources
-- getNeotestAdapters

--[[ 

Empty Env template

return function(config)
  return {
    getFormatOnSavePattern = function()
      return {}
    end,

    getTSEnsureList = function()
      return {}
    end,

    getLSPEnsureList = function()
      return {}
    end,

    getLSPConfigMap = function()
      return {}
    end,

    getToolEnsureList = function()
      return {}
    end,

    getNulllsSources = function()
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end

]]

local enabledEnv = {}

--- @param userConfig UserConfig
local init = function(userConfig)
  table.insert(enabledEnv, require("insis.env.common")(userConfig))
  if userConfig.lua.enable then
    table.insert(enabledEnv, require("insis.env.lua")(userConfig.lua))
  end
  if userConfig.frontend.enable then
    table.insert(enabledEnv, require("insis.env.frontend")(userConfig.frontend))
  end
  if userConfig.golang.enable then
    table.insert(enabledEnv, require("insis.env.golang")(userConfig.golang))
  end
  if userConfig.clangd.enable then
    table.insert(enabledEnv, require("insis.env.clangd")(userConfig.clangd))
  end
  if userConfig.rust.enable then
    table.insert(enabledEnv, require("insis.env.rust")(userConfig.rust))
  end
  if userConfig.bash.enable then
    table.insert(enabledEnv, require("insis.env.bash")(userConfig.bash))
  end
  if userConfig.python.enable then
    table.insert(enabledEnv, require("insis.env.python")(userConfig.python))
  end
  if userConfig.ruby.enable then
    table.insert(enabledEnv, require("insis.env.ruby")(userConfig.ruby))
  end
  if userConfig.json.enable then
    table.insert(enabledEnv, require("insis.env.json")(userConfig.json))
  end
  if userConfig.yaml.enable then
    table.insert(enabledEnv, require("insis.env.yaml")(userConfig.yaml))
  end
  if userConfig.markdown.enable then
    table.insert(enabledEnv, require("insis.env.markdown")(userConfig.markdown))
  end
  if userConfig.docker.enable then
    table.insert(enabledEnv, require("insis.env.docker")(userConfig.docker))
  end
  if userConfig.solidity.enable then
    table.insert(enabledEnv, require("insis.env.solidity")(userConfig.solidity))
  end
  if userConfig.java.enable then
    table.insert(enabledEnv, require("insis.env.java")(userConfig.java))
  end
end

-- loop through enabledEnv list and call envFunc on each Env file
local function collectList(envFunc)
  local list = {}
  for _, env in ipairs(enabledEnv) do
    for _, p in ipairs(env[envFunc]()) do
      if table.indexOf(list, p) == -1 then
        table.insert(list, p)
      end
    end
  end
  return list
end

return {
  init = init,
  getFormatOnSavePattern = function()
    return collectList("getFormatOnSavePattern")
  end,
  getTSEnsureList = function()
    return collectList("getTSEnsureList")
  end,
  getLSPEnsureList = function()
    return collectList("getLSPEnsureList")
  end,
  getToolEnsureList = function()
    return collectList("getToolEnsureList")
  end,
  getLSPConfigMap = function()
    local configMap = {}
    for _, env in ipairs(enabledEnv) do
      for k, v in pairs(env.getLSPConfigMap()) do
        configMap[k] = v
      end
    end
    return configMap
  end,
  getNulllsSources = function()
    return collectList("getNulllsSources")
  end,
  getNeotestAdapters = function()
    return collectList("getNeotestAdapters")
  end,
}
