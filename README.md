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
})
```

`:wq` 保存重启后，会自动安装语法高亮和 Golang Language Server，Linter，Formatter 等。

## 🛠 安装

https://github.com/nshen/InsisVim/assets/181506/ad36e1b1-05f6-47e9-bf2e-6738f539ccce

### 注意事项

- 如缺少以下常见命令行工具，`git`、`wget`、`curl`、`ripgrep`、`nvim v0.9.x`，则有可能安装失败。

  - 在 Mac 上，您可以使用 `brew install` 安装以上工具。
  - 在 Ubuntu 上，您可以检查 [Ubuntu 安装指南](https://github.com/nshen/InsisVim/issues/5)。

- 如之前安装过其他配置，建议先删除或备份以下目录

  - `~/.local/share/nvim`
  - `~/.cache/nvim`
  - `~/.config/nvim`

* 需要科学网络环境，建议开启全局/增强模式等，如遇[网络问题可以到此讨论](https://github.com/nshen/learn-neovim-lua/discussions/categories/q-a?discussions_q=is%3Aopen+category%3AQ%26A+label%3A%E6%8F%92%E4%BB%B6%E5%AE%89%E8%A3%85%E9%97%AE%E9%A2%98)

### 安装步骤

1. 克隆本项目到 Neovim 配置目录

```lua
git clone https://github.com/nshen/InsisVim.git ~/.config/nvim
```

2. 运行 `nvim` ，等待插件全部安装完成

3. 重启

## 自定义配置

自定义配置非常简单，就像配置一个插件一样，只需要修改 `~/.config/nvim/init.lua` 后保存重启即可

```lua
require("insis").setup({
    -- 按需设置参数
})
```

这里支持的参数非常的多，但基本上分为**常用配置**，和**编程环境配置**。

### 常用配置

例如用来设置主题的 `colorscheme` 这类常用的配置，修改后 `:wq` 保存重启即可生效

```lua
require("insis").setup({
    colorscheme = "tokyonight"
})
```

> InsisVim 默认使用 `tokyonight` 主题，同时内置了 `nord`、`onedark`、`gruvbox`、`nightfox`、`nordfox`、`duskfox`、`dracula` 主题。
> 可以通过 `:InsisColorPreview` 命令预览内置主题

https://github.com/nshen/InsisVim/assets/181506/15517b20-acdf-45eb-9db6-9a0d0806cb4a

### 编程环境配置

例如 `Golang` 环境，设置 enable 后，`:wq` 保存重启会自动调用 Mason 安装对应的语法高亮 Language Server，Linter，Formatter 等。安装完毕后再次重启打开对应的 Golang 项目即可生效

```lua
require("insis").setup({
  colorscheme = "tokyonight"
  golang = {
    enable = true,
  },
})
```

开启其他语言相关的模块也都类似，修改 `~/.config/nvim/init.lua` 后保存重启，即可自动完成安装。

由于编程环境启用后需要额外安装LSP Linter Formatter 语法高亮等，所以默认情况下**编程环境配置**都是关闭的，需要手动开启，只有 `Lua` 是默认开启的，这是因为你会经常使用 `Lua` 语言来修改配置。而 **常用配置** 则大部分默认都是开启状态的。

> 完整默认参数列表在此 [config.lua](https://github.com/nshen/InsisVim/blob/main/lua/insis/config.lua)

## 常用编程环境配置

语言环境相关模块请逐个打开，否则重启后一次会安装很多服务，需要等待较长时间。

<details>
<summary>Markdown 编辑</summary>
  
```lua
require("insis").setup({
  markdown = {
    enable = false,
    mkdnflow = {
      next_link = "gn",
      prev_link = "gp",
      next_heading = "gj",
      prev_heading = "gk",
      go_back = "<C-o>",
      follow_link = "gd",
      toggle_item = "tt",
    },
    formatter = "prettier",
    -- 保存时格式化默认为false
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>前端开发</summary>
  
前端开发配置相对比较复杂，因为需要安装多个 LSP，多种文件的语法高亮等，重启后需要等待时间会较长

```lua
require("insis").setup({
  frontend = {
    enable = true,
    -- 下边的都是默认值可以省略
    linter = "eslint_d",
    ---@type "eslint_d" | "prettier" | "tsserver"
    formatter = "tsserver",
    format_on_save = false,
    cspell = false,
    tailwindcss = true,
    prisma = false,
    -- vue will take over typescript lsp
    vue = false,
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

</details>

<details>
<summary>Golang开发</summary>
  
```lua
require("insis").setup({
  golang = {
    enable = true,
    -- 下边的都是默认值可以省略
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>clangd开发</summary>
  
```lua
require("insis").setup({
  clangd = {
    enable = false,
    lsp = "clangd",
    -- linter = "clangd-tidy",
    formatter = "clang-format",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>Bash开发</summary>
  
```lua
require("insis").setup({
  bash = {
    enable = true,
    lsp = "bashls",
    --  brew install shfmt
    formatter = "shfmt",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>Python开发</summary>
  
```lua
require("insis").setup({
  python = {
    enable = true,
    -- can be pylsp or pyright
    lsp = "pylsp",
    -- pip install black
    -- asdf reshim python
    formatter = "black",
    format_on_save = false,
  },
})
```
</details>

<details>
<summary>Ruby开发</summary>
  
```lua
require("insis").setup({
  ruby = {
    enable = true,
    lsp = "ruby_ls",
    -- gem install rubocop
    formatter = "rubocop",
    format_on_save = false,
  },
})
```
</details>

TODO...

## 日常使用

TODO

### 快捷键列表

## 项目结构

如何扩展

TODO

## Requirements

- Neovim v0.9.x.
- Nerd Fonts.

## License

MIT

WIP 🟡, PR is welcome.
