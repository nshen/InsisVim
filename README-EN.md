# InsisVim

> [中文](./README.md)

An out-of-the-box Neovim IDE layer that configures the development environment in an incredibly simple way. For example, to configure `golang`, just:

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

After saving and restarting with `:wq`, syntax highlighting, Golang Language Server, Linter, Formatter, etc., will be automatically installed.

## 🛠 Installation

https://github.com/nshen/InsisVim/assets/181506/ad36e1b1-05f6-47e9-bf2e-6738f539ccce

### Notes

- If the following common command-line tools are missing, `git`, `wget`, `curl`, `ripgrep`, `nvim v0.9.x`, the installation may fail.
  - On Mac, you can use `brew install` to install these tools.
  - On Ubuntu, you can check the [Ubuntu Installation Guide](https://github.com/nshen/InsisVim/issues/5).

- If you have previously installed other configurations, it is recommended to delete or back up the following directories:
  - `~/.local/share/nvim`
  - `~/.cache/nvim`
  - `~/.config/nvim`

* A **scientific network** environment is required. It is recommended to enable **global/enhanced** mode, etc. If you encounter [network issues, you can discuss them here](https://github.com/nshen/learn-neovim-lua/discussions/categories/q-a?discussions_q=is%3Aopen+category%3AQ%26A+label%3A%E6%8F%92%E4%BB%B6%E5%AE%89%E8%A3%85%E9%97%AE%E9%A2%98).

### Installation Steps

1. Clone this project to the Neovim configuration directory

```lua
git clone https://github.com/nshen/InsisVim.git ~/.config/nvim
```

2. Run `nvim` and wait for all plugins to be installed

3. Restart

## Custom Configuration

Custom configuration is very simple, just like configuring a plugin. You only need to modify `~/.config/nvim/init.lua` and save and restart.

```lua
require("insis").setup({
    -- Set parameters as needed
})
```

The supported parameters are numerous, but they are basically divided into **common configurations** and **programming environment configurations**.

### Common Configurations

For example, to set the theme with `colorscheme`, modify and save with `:wq` to take effect.

```lua
require("insis").setup({
    colorscheme = "tokyonight"
})
```

> InsisVim uses the `tokyonight` theme by default and also includes `nord`, `onedark`, `gruvbox`, `nightfox`, `nordfox`, `duskfox`, and `dracula` themes.
> You can preview the built-in themes with the `:InsisColorPreview` command.

https://github.com/nshen/InsisVim/assets/181506/15517b20-acdf-45eb-9db6-9a0d0806cb4a

#### AI Completion

<details>
<summary>Copilot Configuration</summary>
  
```lua
require("insis").setup({
  cmp = {
    -- Enable copilot completion for cmp
    copilot = true,
  },
})
```

InsisVim includes the following plugins, which will be activated upon enabling:

- [copilot.lua](https://github.com/zbirenbaum/copilot.lua)
- [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp)
- [copilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim/tree/canary)

Since Copilot is a paid service, you need to run `:Copilot auth` for authentication before it takes effect. However, if you are a student, teacher, or open-source project contributor, you can [apply for free](https://docs.github.com/en/copilot/quickstart) usage.

> GitHub Copilot is free to use for verified students, teachers, and maintainers of popular open-source projects.

To enable `Copilot Chat` and interact with your code:

```lua
copilot_chat = {
  enable = true,
  keys = {
     -- Quick chat with the current file
     quick_chat = "<leader>cc",
     -- Code Prompt to list various predefined prompts, such as explaining code, refactoring code, adding documentation, etc.
     prompt_actions = "<leader>cp",
     -- Code Help to fix selected errors
     help_actions = "<leader>ch",
     -- Ask Copilot questions directly
     ai = "<leader>ai",
  },
},
```

</details>

<details>
<summary>Codeium Configuration</summary>

```lua
require("insis").setup({
  cmp = {
    -- Enable codeium completion for cmp
    codeium = true,
  },
})
```

InsisVim includes [Codeium.nvim](https://github.com/Exafunction/codeium.nvim), which will be activated upon enabling.

You need to run `:Codeium Auth` for authentication before it takes effect.

</details>

#### Buffers

In the Vim world, a Buffer represents a file loaded into memory. It is very similar to Tabs in VSCode. When you see a tab in VSCode, it means a file is loaded into memory.

In InsisVim, the [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) plugin is used to simulate this behavior, and the configuration is simplified, making it very easy to customize key bindings.

https://github.com/nshen/InsisVim/assets/181506/a639f05b-adab-4279-8482-e3088d2fae8f

<details>
<summary>Bufferline Configuration</summary>
  
```lua
require("insis").setup({
  bufferLine = {
    enable = true,
    keys = {
      -- left / right cycle
      prev = "<C-h>",
      next = "<C-l>",
      -- close current buffer
      close = "<C-w>",
      -- close = "<leader>bc",
      -- close all left / right tabs
      close_left = "<leader>bh",
      close_right = "<leader>bl",
      -- close all other tabs
      close_others = "<leader>bo",
      close_pick = "<leader>bp",
    },
  },
})
```

</details>

#### Super Windows

Unlike VSCode, a Window in Vim is just a window displaying a Buffer, allowing multiple windows to simultaneously display or even modify a Buffer. In InsisVim, you can easily define a series of window-related shortcuts, including horizontal and vertical splits, quick window jumps, closing, etc., called Super Windows.

<details>
<summary>Super Windows Configuration</summary>
  
```lua
require("insis").setup({
  s_windows = {
    enable = true,
    keys = {
      split_vertically = "sv",
      split_horizontally = "sh",
      -- close current
      close = "sc",
      -- close others
      close_others = "so",
      -- jump between windows
      jump_left = { "<A-h>", "<leader>h" },
      jump_right = { "<A-l>", "<leader>l" },
      jump_up = { "<A-k>", "<leader>k" },
      jump_down = { "<A-j>", "<leader>j" },
      -- control windows size
      width_decrease = "s,",
      width_increase = "s.",
      height_decrease = "sj",
      height_increase = "sk",
      size_equal = "s=",
    },
  },
})
```

</details>

#### Super Tab

A Tab in Vim is used to save a combination of one or more windows, allowing you to switch to different Tabs without changing the window layout, using different window layouts for different tasks.

In InsisVim, you can also quickly define a set of tab-related shortcuts, called Super Tab.

<details>
<summary>Super Tab Configuration</summary>

Note that super tab is not commonly used, so it is disabled by default and needs to be manually enabled.

```lua
require("insis").setup({
  s_tab = {
    enable = true, -- Disabled by default
    keys = {
      split = "ts",
      prev = "th",
      next = "tl",
      first = "tj",
      last = "tk",
      close = "tc",
    },
  },
})
```

</details>

---

In short, the relationship between Buffers, Windows, and Tabs is as follows:

- A buffer is a file loaded into memory. We use the bufferline plugin to simulate the behavior of VSCode's tabs.
- A window displays a buffer. Familiarity with quick window splits and shortcuts for jumping between windows is key to improving development efficiency.
- A tab organizes window layouts. It is usually not needed, so it is disabled by default.

<img width="762" alt="image" src="https://github.com/nshen/InsisVim/assets/181506/fb10bd17-895a-4f67-9718-87e11eb538b3">

---

### Programming Environment Configuration

For example, the `Golang` environment. After setting `enable` to true and saving and restarting with `:wq`, Mason will automatically install the corresponding syntax highlighting, Language Server, Linter, Formatter, etc. After installation, restart and open the corresponding Golang project to take effect.

```lua
require("insis").setup({
  colorscheme = "tokyonight"
  golang = {
    enable = true,
  },
})
```

Enabling other language-related modules is similar. Modify `~/.config/nvim/init.lua`, save and restart to automatically complete the installation.

Since enabling the programming environment requires additional installation of LSP, Linter, Formatter, syntax highlighting, etc., by default, **programming environment configurations** are disabled and need to be manually enabled. Only `Lua` is enabled by default because you will often use the `Lua` language to modify configurations. Most **common configurations** are enabled by default.

> The complete default parameter list is here [config.lua](https://github.com/nshen/InsisVim/blob/main/lua/insis/config.lua)

## Common Programming Environment Configurations

Enable language environment-related modules one by one, otherwise, restarting will install many services at once, requiring a long wait.

<details>
<summary>JSON Editing</summary>
  
```lua
require("insis").setup({
  json = {
    enable = true,
    -- The following are default values and can be omitted
    lsp = "jsonls",
    ---@type "jsonls" | "prettier"
    formatter = "jsonls",
    format_on_save = false,
    indent = 2,
   }
})
```

After enabling `json` and restarting:

- Treesitter's JSON syntax highlighting will be automatically installed.
- The [jsonls](https://github.com/microsoft/vscode-json-languageservice) Language Server will be automatically installed and configured.

</details>

<details>
<summary>Markdown Editing</summary>
  
```lua
require("insis").setup({
  markdown = {
    enable = true,
    -- The following are default values and can be omitted
    mkdnflow = {
      next_link = "gn",
      prev_link = "gp",
      next_heading = "gj",
      prev_heading = "gk",
      -- Follow link
      follow_link = "gd",
      -- Go back from link
      go_back = "<C-o>",
      toggle_item = "tt",
    },
    formatter = "prettier",
    -- Format on save is false by default
    format_on_save = false,
    -- Wrap text at the edge by default
    wrap = true,
    ---:MarkdownPreview command opens article preview with dark theme by default
    ---@type "dark" | "light"
    theme = "dark",
  },
})
```

After enabling markdown and restarting, Treesitter's markdown syntax highlighting and prettier for formatting will be automatically installed.

Adds the `:MarkdownPreview` command for real-time preview of markdown files.

Adds `mkdnflow.nvim` related shortcuts.

Adds markdown-related shortcuts such as `5x5table`.

</details>

<details>
<summary>Frontend Development</summary>
  
Frontend development configuration is relatively complex because it requires installing multiple LSPs, various file syntax highlighting, etc. Restarting will take a long time.

```lua
require("insis").setup({
  frontend = {
    enable = true,
    ---@type "eslint" | false
    linter = "eslint", -- :EslintFixAll command added
    ---@type false | "prettier" | "tsserver"
    formatter = "tsserver",
    format_on_save = false,
    indent = 4,
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
<summary>Solidity Development</summary>
  
```lua
require("insis").setup({
  solidity = {
    enable = true,
    --linter can be sohint or false
    linter = "solhint",
    format_on_save = true,
    indent = 4,
  },
})
```

When `enable` is set to `true` and restarted, the following will be installed:

- TreeSitter syntax highlighting: `solidity`
- Language Server: [nomicfoundation-solidity-language-server](https://github.com/NomicFoundation/hardhat-vscode/tree/development/server)
- Code snippets: [solidity snippets](https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/solidity.json)
- If a linter is set, [sohint](https://github.com/protofire/solhint) will be automatically downloaded and started.

</details>

<details>
<summary>Golang Development</summary>
  
```lua
require("insis").setup({
  golang = {
    enable = true,
    -- The following are default values and can be omitted
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = false,
    indent = 4,
  },
})
```

</details>

<details>
<summary>Clangd Development</summary>
  
```lua
require("insis").setup({
  clangd = {
    enable = true,
    lsp = "clangd",
    -- linter = "clangd-tidy",
    formatter = "clang-format",
    format_on_save = false,
    indent = 4,
  },
})
```

</details>

<details>
<summary>Bash Development</summary>
  
```lua
require("insis").setup({
  bash = {
    enable = true,
    lsp = "bashls",
    --  brew install shfmt
    formatter = "shfmt",
    format_on_save = false,
    indent = 4,
  },
})
```

</details>

<details>
<summary>Python Development</summary>
  
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
    indent = 4,
  },
})
```

</details>

<details>
<summary>Ruby Development</summary>
  
```lua
require("insis").setup({
  ruby = {
    enable = true,
    lsp = "ruby_ls",
    -- gem install rubocop
    formatter = "rubocop",
    format_on_save = false,
    indent = 2,
  },
})
```

</details>

<details>
<summary>Docker Development</summary>
  
```lua
require("insis").setup({
  docker = {
    enable = true,
    lsp = "dockerls",
    indent = 2,
  },
})
```

</details>

## Daily Use

### Common Commands

- Update plugins:
  - `:Lazy restore` to update all plugins to the stable versions locked in `lazy-lock.json`
  - `:Lazy update` to update all plugins to the latest versions, compatibility not guaranteed
- View error messages:
  - `:Notifications`
  - `:messages`
- View/install LSP:
  - `:LspInfo` to view running status
  - `:Mason` for installation and updates
- Update syntax highlighting:
  - `:TSUpdate` to update all
  - `:TSUpdate <json>` to update individually
- Markdown preview:
  - `:MarkdownPreview`

### Code Folding Shortcuts

| Fold Shortcuts | Description     |
| -------------- | --------------- |
| zc             | Close fold      |
| zo             | Open fold       |
| za             | Toggle fold     |
| zM             | Close all folds |
| zR             | Open all folds  |

Updating...

## Contect

If you have questions, please [contect me](https://www.nshen.net/about).

## Project Structure

How to extend

TODO

## Requirements

- Neovim v0.9.x.
- Nerd Fonts.

## License

MIT

WIP 🟡, PR is welcome.

