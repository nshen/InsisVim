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
  },

  strategies = {
    chat = { adapter = "copilot" },
    inline = { adapter = "copilot" },
    -- copilot
    -- choices = {
    --   ["o3-mini-2025-01-31"] = { opts = { can_reason = true } },
    --   ["o1-2024-12-17"] = { opts = { can_reason = true } },
    --   ["o1-mini-2024-09-12"] = { opts = { can_reason = true } },
    --   "claude-3.5-sonnet",
    --   "gpt-4o-2024-08-06",
    --   "gemini-2.0-flash-001",
    -- },
  },

  opts = {
    language = "Chinese",
  },
  -------------------------------------------
  prompt_library = {
    ["DeepSeek Explain In Chinese"] = require("insis.utils.promps.deepseek-explain"),
    ["Nextjs Helper"] = require("insis.utils.promps.nextjs-helper"),
  },
})

keymap({ "n", "v", "x" }, cfg.codecompanion.keys.toggle_chat, function()
  code.toggle()
end)

keymap({ "n", "v", "x" }, cfg.codecompanion.keys.prompt_actions, ":CodeCompanionActions<CR>")

-- https://github.com/olimorris/codecompanion.nvim/discussions/640
local fidget = pRequire("fidget")
local handler
if fidget then
  -- Attach:
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequest*",
    group = vim.api.nvim_create_augroup("CodeCompanionHooks", {}),
    callback = function(request)
      if request.match == "CodeCompanionRequestStarted" then
        if handler then
          handler.message = "Abort."
          handler:cancel()
          handler = nil
        end
        handler = fidget.progress.handle.create({
          title = "",
          message = "Thinking...",
          lsp_client = { name = "CodeCompanion" },
        })
      elseif request.match == "CodeCompanionRequestFinished" then
        if handler then
          handler.message = "Done."
          handler:finish()
          handler = nil
        end
      end
    end,
  })
end
