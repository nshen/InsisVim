return {

  strategy = "workflow",
  description = "Nextjs Helper",
  opts = {
    is_default = false,
    short_name = "nextjs",
    ignore_system_prompt = true,
    -- adapter = "copilot_claude",
  },
  references = {
    {
      type = "file",
      path = {
        "package.json",
      },
    },
  },
  prompts = {
    {
      -- We can group prompts together to make a workflow
      -- This is the first prompt in the workflow
      -- Everything in this group is added to the chat buffer in one batch
      {
        role = "system",
        content = function(_)
          return "As a senior Nextjs 15 developer. Your task is to design and generate high-quality Next.js components based on user prompts, ensuring it is functional, clean, and follows best practices."
            .. "When generating code, always use shadcn ui components or library from package.json file, unless otherwise specified. if you use any shadcn component, don't forget to tell me how to install it in both npx and pnpm way."
            .. "Style with tailwindcss. Responsive design, mobile-first principle."
            .. "You can use lucide-react or react-icons if you see that the user's request requires icons."
        end,
        -- 详细规则
        -- react-hook-form + zod ?
        -- 样式 间距，颜色，字体，字号，行高，阴影，圆角，边框，背景色，hover，active，focus，disabled
        --
        opts = {
          visible = false,
          ignore_system_prompt = true,
        },
      },
      {
        role = "user",
        content = "我想要",
        opts = {
          auto_submit = false,
          ignore_system_prompt = true,
        },
      },
    },
    -- This is the second group of prompts
    {
      {
        role = "user",
        opts = {
          auto_submit = false,
          ignore_system_prompt = true,
        },
        content = function()
          -- Leverage auto_tool_mode which disables the requirement of approvals and automatically saves any edited buffer
          vim.g.codecompanion_auto_tool_mode = true

          -- Some clear instructions for the LLM to follow
          return [[### Instructions Steps to Follow

@files 你被要求严格按照以下指示执行任务：

1. @files 创建该组件文件，保存到 components 文件夹内，文件名为 `xxxx.tsx` 。
2. 在 app/playground/ + 组件名 目录下创建一个测试页面，并引入该组件。
3. 打印出测试网址，让用户查看效果，网址通常为 http://localhost:3000/playground/ + 组件名。]]
        end,
      },
    },
  },
}
