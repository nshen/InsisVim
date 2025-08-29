local code = pRequire("codecompanion")
local cfg = require("insis").config

if not code then
  return
end
code.setup({
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        show_result_in_chat = true, -- Show mcp tool results in chat
        make_vars = true, -- Convert resources to #variables
        make_slash_commands = true, -- Add prompts as /slash commands
      },
    },
  },
  adapters = {
    http = {

      opts = {
        -- show_defaults will cause copilot to not work properly
        show_defaults = true,
        show_model_choices = true,
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
      -- Aliyun Qwen
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
              -- default = "claude-sonnet-4",
              default = "gpt-4.1",
            },
          },
        })
      end,

      copilot_free = function()
        return require("codecompanion.adapters").extend("copilot", {
          name = "copilot_free",
          schema = {
            model = {
              default = "gpt-4.1",
            },
          },
        })
      end,

      openrouter_claude = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          name = "openrouter_claude",
          env = {
            url = "https://openrouter.ai/api",
            api_key = "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",
            chat_url = "/v1/chat/completions",
          },
          schema = {
            model = {
              default = "anthropic/claude-3.7-sonnet",
              -- default = "google/gemini-2.0-flash-exp:free",
            },
          },
        })
      end,

      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          name = "gemini",
          env = {
            api_key = function()
              return "AIzaSyAHCLoZQ-ZASFajOnyFNEQhOvBUBwZQrTo"
              -- return os.getenv("GEMINI_API_KEY")
            end,
          },
          schema = {
            model = {
              default = "gemini-2.5-pro",
            },
          },
        })
      end,
    },
    acp = {
      gemini_cli = function()
        return require("codecompanion.adapters").extend("gemini_cli", {
          commands = {
            flash = {
              "gemini",
              "--experimental-acp",
              "-m",
              "gemini-2.5-flash",
            },
            pro = {
              "gemini",
              "--experimental-acp",
              "-m",
              "gemini-2.5-pro",
            },
          },
          defaults = {
            -- auth_method = "gemini-api-key", -- "oauth-personal" | "gemini-api-key" | "vertex-ai"
            auth_method = "oauth-personal",
            -- auth_method = "vertex-ai",
          },
        })
      end,
    },
  },

  strategies = {
    -- chat = { adapter = "openrouter_claude" },
    chat = { adapter = "copilot" },
    inline = { adapter = "copilot" },
  },

  opts = {
    language = "Chinese",
  },
  -------------------------------------------
  prompt_library = {
    ["Simple Git Commit Message"] = require("insis.ai.codecompanion.prompts.simple-git-commit-message"),
    ["DeepSeek Explain"] = require("insis.ai.codecompanion.prompts.deepseek-explain"),
    ["Nextjs Agant"] = require("insis.ai.codecompanion.prompts.nextjs-agant"),
    ["Nextjs Modifier"] = require("insis.ai.codecompanion.prompts.nextjs-modifier"),
  },
})

keymap({ "n", "v", "x" }, cfg.codecompanion.keys.toggle_chat, function()
  code.toggle()
end)

keymap({ "n", "v", "x" }, cfg.codecompanion.keys.prompt_actions, ":CodeCompanionActions<CR>")

require("insis.ai.codecompanion/fidget").init()
