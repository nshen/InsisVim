return {
  strategy = "chat",
  description = "Simple Git Commit Message",
  opts = {
    index = 10,
    is_default = true,
    is_slash_cmd = true,
    short_name = "commit",
    auto_submit = true,
  },
  prompts = {
    {
      role = "user",
      content = function()
        return string.format(
          [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a simple one sentence commit message in English:

```diff
%s
```
]],
          vim.fn.system("git diff --no-ext-diff --staged")
        )
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
