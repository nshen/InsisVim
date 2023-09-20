# InsisVim

一个开箱即用的 Neovim IDE 层，以难以置信的简单方式配置开发环境，例如配置 `golang`，只需：

```lua
require("insis").setup({
  golang = {
    enable = true,
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = true,
  },
  -- 在此开启更多特性
})
```

## Preview

https://github.com/nshen/InsisVim/assets/181506/ca0fe9a0-122f-471a-bbe0-7656e0304309

## 🛠 安装

### 注意事项 

- 如缺少以下常见命令行工具，`git`、`wget`、`curl`、`ripgrep`、`nvim v0.9.x`，则有可能安装失败。

   - 在 Mac 上，您可以使用 `brew install` 安装以上工具。
   - 在 Ubuntu 上，您可以检查 [Ubuntu 安装指南](https://github.com/nshen/InsisVim/issues/5)。

- 如之前安装过其他配置，建议先删除或备份以下目录

   - `~/.local/share/nvim`
   - `~/.cache/nvim`
   - `~/.config/nvim`

* 需要科学网络环境，建议开启全局/增强模式等，如遇[网络问题可以到此讨论](https://github.com/nshen/learn-neovim-lua/discussions/categories/q-a?discussions_q=is%3Aopen+category%3AQ%26A+label%3A%E6%8F%92%E4%BB%B6%E5%AE%89%E8%A3%85%E9%97%AE%E9%A2%98)

#### 安装步骤

1. 克隆本项目到 Neovim 配置目录

`git clone https://github.com/nshen/InsisVim.git ~/.config/nvim`

2. 运行 `nvim` ，等待插件全部安装完成

3. 重启

## 自定义配置

大部分内置模块默认是开启状态，而**编程环境**相关的模块只有 `Lua` 是默认开启的，这是因为你会经常使用 `Lua` 语言来修改配置。

开启其他语言相关的模块非常简单，只需要修改 `~/.config/nvim/init.lua` 后保存重启，即可自动完成安装。

```lua
require("insis").setup({
    -- 按需设置参数
})
```

比如启用 `Golang` 开发只需要：

```lua
require("insis").setup({
  golang = {
    enable = true,
    format_on_save = true,
  },
})
```

保持科学网络环境畅通，`:wq` 保存重启后会自动安装 `Golang` 的 `Language Server`，语法高亮，`golangci-lint` 等.

其他语言配置也类似，完整参数列表在此 [config.lua](https://github.com/nshen/InsisVim/blob/main/lua/insis/config.lua) 还没有完善的文档，暂时请大家自行研究。

目前只有前端开发配置较复杂，因为需要安装多个 LSP，多种文件的语法高亮等

### Frontend development

```lua
require("insis").setup({
  frontend = {
    enable = true,
    prisma = true,
    vue = false,
    format_on_save = true,
    code_actions = "eslint_d",
    ---@type "eslint_d" | "prettier"
    formatter = "prettier",
    cspell = false,
    -- extra lsp command provided by typescript.nvim
    typescript = {
      keys = {
        ts_organize = "gs",
        ts_rename_file = "gR",
        ts_add_missing_import = "ga",
        ts_remove_unused = "gu",
        ts_fix_all = "gf",
        ts_goto_source = "gD",
      },
    },
  },
})
```

目前我在用的配置如下，仅供参考，语言环境相关模块请逐个打开，否则重启后一次会安装很多服务，需要等待较长时间。

```lua
require("insis").setup({
  clangd = {
    enable = true,
  },
  git = {
    current_line_blame = true,
  },
  enable_imselect = true,
  enable_very_magic_search = true,
  lua = {
    enable = true,
  },
  markdown = {
    enable = true,
    -- formatter = false,
    format_on_save = true,
  },
  golang = {
    enable = true,
    format_on_save = true,
  },
  json = {
    enable = true,
    format_on_save = false,
  },
  yaml = {
    enable = true,
  },
  docker = {
    enable = true,
  },
  frontend = {
    enable = true,
    prisma = true,
    vue = false,
    format_on_save = true,
    code_actions = "eslint_d",
    ---@type "eslint_d" | "prettier"
    formatter = "prettier",
    cspell = false,
    -- extra lsp command provided by typescript.nvim
    typescript = {
      keys = {
        ts_organize = "gs",
        ts_rename_file = "gR",
        ts_add_missing_import = "ga",
        ts_remove_unused = "gu",
        ts_fix_all = "gf",
        ts_goto_source = "gD",
      },
    },
  },
  -- yaml = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  --
  -- clangd = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  --
  -- rust = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  --
  -- bash = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  --
  -- python = {
  --   enable = true,
  --   format_on_save = true,
  -- },
  -- ruby = {
  --   enable = true,
  -- },
})

```

## Requirements

- Neovim v0.9.x.
- Nerd Fonts.

## License

MIT

WIP 🟡, PR is welcome.
