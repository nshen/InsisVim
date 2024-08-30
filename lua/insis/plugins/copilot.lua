local M = {}

M.copilot = function()
  local copilot = pRequire("copilot")
  if not copilot then
    return
  end
  copilot.setup({
    suggestion = { enabled = false, auto_trigger = true },
    panel = { enabled = false },
  })
end

M.copilot_cmp = function()
  local cmpConfig = require("insis").config.cmp
  if not cmpConfig or not cmpConfig.copilot then
    return
  end
  local copilot_cmp = pRequire("copilot_cmp")
  if copilot_cmp then
    copilot_cmp.setup()
  end
end

M.copilot_chat = function()
  local copilot_chat_config = require("insis").config.copilot_chat
  local copilot_chat = pRequire("CopilotChat")
  if not copilot_chat or not copilot_chat_config or not copilot_chat_config.enable then
    return
  end
  copilot_chat.setup({
    debug = false,
    auto_follow_cursor = false,
    prompts = {
      -- Text related prompts
      Translate = "Please translate the following text into English.",
      Summarize = "Please summarize the following text.",
      Spelling = "Please correct any grammar and spelling errors in the following text.",
      Wording = "Please improve the grammar and wording of the following text.",
      Concise = "Please rewrite the following text to make it more concise.",
    },
  })
  -- Custom buffer for CopilotChat
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "copilot-*",
    callback = function()
      vim.opt_local.relativenumber = true
      vim.opt_local.number = true

      -- Get current filetype and set it to markdown if the current filetype is copilot-chat
      local ft = vim.bo.filetype
      if ft == "copilot-chat" then
        vim.bo.filetype = "markdown"
      end
    end,
  })

  local cmp = pRequire("cmp")
  if cmp then
    require("CopilotChat.integrations.cmp").setup()
  end
  local telescope = pRequire("telescope")
  if not telescope then
    return
  end
  local actions = require("CopilotChat.actions")
  local copilot_telescope = require("CopilotChat.integrations.telescope")
  keymap({ "n", "v", "x" }, copilot_chat_config.keys.help_actions, function()
    copilot_telescope.pick(actions.help_actions())
  end)
  keymap({ "n", "v", "x" }, copilot_chat_config.keys.prompt_actions, function()
    copilot_telescope.pick(actions.prompt_actions())
  end)
  keymap({ "n", "v", "x" }, copilot_chat_config.keys.quick_chat, function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
      copilot_chat.ask(input)
    end
  end)
end

return M
