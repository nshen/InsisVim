# InsisVim

An out-of-the-box Neovim IDE layer that setup development environment in an incredibly simple way.

一个开箱即用的 Neovim IDE 层,以难以置信的简单方式设置开发环境。

```lua
require("insis").setup({
  -- enable features here
  golang = {
    enable = true,
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = true,
  },
})
```

## Preview

https://github.com/nshen/InsisVim/assets/181506/ca0fe9a0-122f-471a-bbe0-7656e0304309

## 🛠 Installation 安装

`npx zx https://insisvim.github.io/install.mjs`

> Note: If any of `git`, `wget`, `curl`, `ripgrep`, `node.js v16+`, `nvim v0.9.x` are missing, the installation will exit and prompt you.

> 注意: 安装之前应确保有 `git`、`wget`、`curl`、`ripgrep`、`node.js v16+、nvim v0.9.x` ，中的任何一个，安装将退出，并提示您。

On Mac you can `brew install` anything above.

在 Mac 上,您可以使用 `brew install` 安装以上任何内容。

On Ubuntu you can check [Ubuntu installation guide](https://github.com/nshen/InsisVim/issues/5).

在 Ubuntu 上,您可以检查 [Ubuntu 安装指南](https://github.com/nshen/InsisVim/issues/5)。

Then try again.

然后再试一次。


## Setup and Configuration

Edit `~/.config/nvim/init.lua`

```lua
require("insis").setup({
    -- Set parameters as needed
    -- 按需设置参数
})
```

Most built-in modules are enabled by default, but programming environment-related modules are disabled by default. Enabling them is also very simple. For example, to enable Golang development, just:

大部分内置模块默认是开启状态，编程环境相关的模块默认则是关闭状态，启用也很简单，比如启用 Golang 开发只需要：

```lua
require("insis").setup({
  golang = {
    enable = true,
    format_on_save = true,
  },
})
```

Keep the network environment smooth, `:wq` save and restart will automatically install the Golang Language Server, syntax highlighting, golangci-lint.

保持科学网络环境畅通，`:wq` 保存重启后会自动安装 Golang 的 Language Server，语法高亮，golangci-lint.

The configuration of other languages is similar. The complete parameter list is in this [config.lua](https://github.com/nshen/InsisVim/blob/main/lua/insis/config.lua). The documentation is not yet complete. Please try it yourself.

其他语言配置也类似，完整参数列表在此 [config.lua](https://github.com/nshen/InsisVim/blob/main/lua/insis/config.lua) 还没有完善的文档，请大家自行研究。

Currently, only front-end development configuration is more complex, because it requires the installation of multiple LSPs, syntax highlighting for various file types, etc.

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

The configuration I am currently using is as follows, for reference only. Please turn on the language environment-related modules one by one, otherwise after restarting, many services will be installed at once and it will take a long time to wait.

目前我在用的配置如下，仅供参考，语言环境相关模块请逐个打开，否则重启后一次会安装很多服务，需要等待较长时间。

```lua
require("insis").setup({
  clangd = {
    enable = true,
  },
  git = {
    current_line_blame = true,
  },
  lock_plugin_commit = false,
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
- Node.js v16+.
- Nerd Fonts.

## License

MIT

WIP 🟡, PR is welcome.
