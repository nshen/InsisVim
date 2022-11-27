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
## Preview

TODO

##  Stellar Features

## Requirements

- Neovim v0.8.x.
- Node.js v16+.
- Nerd Fonts.

## 🛠 Installation

`npx zx https://insisvim.github.io/install.mjs`

## License

MIT


