--- @param config JavaConfig
return function(config)
    return {
        getFormatOnSavePattern = function()
            if config.format_on_save then
                return { "*.java" }
            end
            return {}
        end,

        getTSEnsureList = function()
            return { "java" }
        end,

        getLSPEnsureList = function()
            return { "jdtls" }
        end,

        getLSPConfigMap = function()
            return {
                jdtls = require("insis.lsp.config.jdtls"), -- lua/lsp/config/jdtls.lua
            }
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