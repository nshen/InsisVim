local code = pRequire("codecompanion")
local cfg = require("insis").config

if not code then
  return
end

code.setup({
  adapters = {
    opts = {
      -- show_defaults 会导致copilot不能正常工作
      show_defaults = true,
      -- log_level = "DEBUG",
    },

    deepseek = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "deepseek",
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

    siliconflow_r1 = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "siliconflow_r1",
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

    siliconflow_v3 = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "siliconflow_v3",
        url = "https://api.siliconflow.cn/v1/chat/completions",
        env = {
          api_key = function()
            return os.getenv("DEEPSEEK_API_KEY_S")
          end,
        },
        schema = {
          model = {
            default = "deepseek-ai/DeepSeek-V3",
            choices = {
              "deepseek-ai/DeepSeek-V3",
              ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
            },
          },
        },
      })
    end,

    aliyun_deepseek = function()
      return require("codecompanion.adapters").extend("deepseek", {
        name = "aliyun_deepseek",
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
            },
          },
        },
      })
    end,
    -- 阿里千问
    -- https://help.aliyun.com/zh/model-studio/getting-started/models?spm=a2c4g.11186623.0.0.ce3c4823l7PTRL#9f8890ce29g5u
    aliyun_qwen = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        name = "aliyun_qwen",
        env = {
          url = "https://dashscope.aliyuncs.com",
          api_key = function()
            return os.getenv("DEEPSEEK_API_ALIYUN")
          end,
          chat_url = "/compatible-mode/v1/chat/completions",
        },
        schema = {
          model = {
            default = "qwen-coder-plus-latest",
          },
        },
      })
    end,

    copilot_claude = function()
      return require("codecompanion.adapters").extend("copilot", {
        name = "copilot_claude",
        schema = {
          model = {
            default = "claude-3.7-sonnet",
          },
        },
      })
    end,
  },

  strategies = {
    chat = { adapter = "copilot_claude" },
    inline = { adapter = "copilot_claude" },
  },

  opts = {
    language = "Chinese",
  },
  -------------------------------------------
  prompt_library = {
    ["DeepSeek Explain"] = require("insis.ai.codecompanion.prompts.deepseek-explain"),
    ["Nextjs Agant"] = require("insis.ai.codecompanion.prompts.nextjs-agant"),
  },
})

keymap({ "n", "v", "x" }, cfg.codecompanion.keys.toggle_chat, function()
  code.toggle()
end)

keymap({ "n", "v", "x" }, cfg.codecompanion.keys.prompt_actions, ":CodeCompanionActions<CR>")

require("insis.ai.codecompanion/fidget").init()
