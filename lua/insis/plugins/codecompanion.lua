local code = pRequire("codecompanion")

if code then
  code.setup({
    adapters = {
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
      siliconflow = function()
        return require("codecompanion.adapters").extend("deepseek", {
          url = "https://api.siliconflow.cn/v1/chat/completions",
          env = {
            api_key = function()
              return os.getenv("DEEPSEEK_API_KEY_S")
            end,
          },
          schema = {
            model = {
              default = "deepseek-ai/DeepSeek-R1",
              choices = {
                ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
                "deepseek-ai/DeepSeek-V3",
              },
            },
          },
        })
      end,
      aliyun = function()
        return require("codecompanion.adapters").extend("deepseek", {
          url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
          env = {
            api_key = function()
              return os.getenv("DEEPSEEK_API_ALIYUN")
            end,
          },
          schema = {
            model = {
              default = "deepseek-r1",
              choices = {
                ["deepseek-r1"] = { opts = { can_reason = true } },
                "qwen-omni-turbo-latest",
              },
            },
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = "siliconflow" },
      inline = { adapter = "copilot" },
    },
  })
end
