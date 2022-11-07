local indent_blankline = pRequire("indent_blankline")
if indent_blankline then
  indent_blankline.setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    context_patterns = {
      "class",
      "function",
      "method",
      "element",
      "^if",
      "^while",
      "^for",
      "^object",
      "^table",
      "block",
      "arguments",
    },
    -- echo &filetype
    filetype_exclude = {
      "null-ls-info",
      "dashboard",
      "packer",
      "terminal",
      "help",
      "log",
      "markdown",
      "TelescopePrompt",
      "lsp-installer",
      "lspinfo",
      "toggleterm",
      "text",
    },
    -- char = '¦'
    -- char = '┆'
    -- char = '│'
    -- char = "⎸",
    char = "▏",
  })
end
