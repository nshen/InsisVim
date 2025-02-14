local code = pRequire("codecompanion")

if code then
  code.setup({
    adapters = {
      siliconflow = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://api.siliconflow.cn", -- optional: default value is ollama url http://127.0.0.1:11434
            api_key = function()
              return os.getenv("DEEPSEEK_API_KEY_S")
            end,
            chat_url = "/v1/chat/completions", -- optional: default value, override if different
          },
          schema = {
            model = {
              default = "deepseek-ai/DeepSeek-V3",
            },
          },
        })
      end,
      aliyun = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "https://dashscope.aliyuncs.com", -- optional: default value is ollama url http://127.0.0.1:11434
            api_key = function()
              return os.getenv("DEEPSEEK_API_ALIYUN")
            end,
            chat_url = "/compatible-mode/v1/chat/completions", -- optional: default value, override if different
          },
          schema = {
            model = {
              default = "deepseek-r1",
            },
          },
        })
      end,
      deepseek = function()
        return require("codecompanion.adapters").extend("deepseek", {
          env = {
            api_key = function()
              return os.getenv("DEEPSEEK_API_KEY")
            end,
          },
          schema = {
            model = {
              default = "deepseek-coder",
            },
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = "aliyun" },
      inline = { adapter = "copilot" },
    },
  })
end
