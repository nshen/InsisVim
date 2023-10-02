local indent_blankline = pRequire("ibl")
if indent_blankline then
  indent_blankline.setup({
    -- space_char_blankline = " ",
    scope = {
      show_start = true,
    },
    exclude = {
      filetypes = {
        "checkhealth",
        "man",
        "gitcommit",
        "null-ls-info",
        "dashboard",
        "packer",
        "terminal",
        "help",
        "log",
        "markdown",
        "TelescopePrompt",
        "TelescopeResults",
        "lsp-installer",
        "lspinfo",
        "toggleterm",
        "text",
        "''",
      },
    },
    indent = {
      -- char = '¦'
      -- char = '┆'
      -- char = '│'
      -- char = "⎸",
      char = "▏",
    },
  })
end
