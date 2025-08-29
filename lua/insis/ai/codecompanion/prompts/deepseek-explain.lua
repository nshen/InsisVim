return {
  strategy = "chat",
  description = "中文解释代码",
  opts = {
    is_slash_cmd = false,
    modes = { "v" },
    short_name = "explain in chinese",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
    adapter = {
      name = "siliconflow_r1",
      model = "deepseek-ai/DeepSeek-R1",
    },
  },
  prompts = {
    {
      role = "system",
      content = [[当被要求解释代码时，请遵循以下步骤：

  1. 识别编程语言。
  2. 描述代码的目的，并引用该编程语言的核心概念。
  3. 解释每个函数或重要的代码块，包括参数和返回值。
  4. 突出说明使用的任何特定函数或方法及其作用。
  5. 如果适用，提供该代码如何融入更大应用程序的上下文。]],
      opts = {
        visible = false,
      },
    },
    {
      role = "user",
      content = function(context)
        local input = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return string.format(
          [[请解释 buffer %d 中的这段代码:

  ```%s
  %s
  ```
  ]],
          context.bufnr,
          context.filetype,
          input
        )
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
