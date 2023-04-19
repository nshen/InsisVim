-- TODO:
local mkdnflow = pRequire("mkdnflow")
local cfg = require("insis").config.markdown

if mkdnflow and cfg and cfg.enable then
  mkdnflow.setup({
    modules = {
      maps = false,
    },
    filetypes = { md = true, mdx = true, markdown = true },
    links = {
      style = "markdown",
      implicit_extension = nil,
      transform_implicit = false,
      transform_explicit = function(text)
        text = text:gsub(" ", "-")
        text = text:lower()
        text = os.date("%Y-%m-%d-") .. text
        return text
      end,
    },
  })

  local mkdnflowGroup = vim.api.nvim_create_augroup("mkdnflowGroup", {
    clear = true,
  })
  vim.api.nvim_create_autocmd("FileType", {
    group = mkdnflowGroup,
    pattern = { "markdown", "md", "mdx" },
    callback = function()
      local opts = { buffer = vim.api.nvim_get_current_buf() }
      keymap("n", cfg.mkdnflow.next_link, "<cmd>MkdnNextLink<CR>", opts)
      keymap("n", cfg.mkdnflow.prev_link, "<cmd>MkdnPrevLink<CR>", opts)
      keymap("n", cfg.mkdnflow.prev_heading, "<cmd>MkdnPrevHeading<CR>", opts)
      keymap("n", cfg.mkdnflow.next_heading, "<cmd>MkdnNextHeading<CR>", opts)
      keymap("n", cfg.mkdnflow.go_back, "<cmd>MkdnGoBack<CR>", opts)
      keymap("n", cfg.mkdnflow.follow_link, "<cmd>MkdnFollowLink<CR>", opts)
      keymap("n", cfg.mkdnflow.toggle_item, "<cmd>MkdnToggleToDo<CR>", opts)
      keymap({ "n", "x" }, cfg.mkdnflow.follow_link, "<cmd>MkdnFollowLink<CR>", opts)
      local lsp = require("insis").config.lsp
      keymap("n", lsp.code_action, "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
      keymap("n", lsp.format, "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    end,
  })
end
