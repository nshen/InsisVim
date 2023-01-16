# InsisVim

An out-of-the-box Neovim IDE layer that setup development environment in an incredibly simple way.

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

## 🛠 Installation

`npx zx https://insisvim.github.io/install.mjs`

>Note: The installation will stop if you miss any of `git`, `wget`, `curl`, `ripgrep`, `node.js v16+`, `nvim v0.8.x`.

On Mac you can `brew install` anything above.

On Ubuntu you can check [Ubuntu installation guide](https://github.com/nshen/InsisVim/issues/5).

Then try again.

## Preview

TODO

## Setup and Configuration

TODO

## Requirements

- Neovim v0.8.x.
- Node.js v16+.
- Nerd Fonts.



## License

MIT

PR is Welcome.


