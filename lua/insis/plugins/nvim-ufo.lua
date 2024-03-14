vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local ufo = pRequire("ufo")
if not ufo then
  log("couldn't find nvim-ufo.nvim")
  return
end

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)
vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
vim.keymap.set("n", "zm", ufo.closeFoldsWith)

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  table.insert(newVirtText, { " ", "MoreMsg" })
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      -- table.insert(newVirtText, "  ")
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

ufo.setup({
  open_fold_hl_timeout = 100,
  ---@diagnostic disable-next-line: unused-local
  provider_selector = function(bufnr, filetype, buftype)
    return { "lsp", "indent" }
  end,
  fold_virt_text_handler = handler,
})

-- vim.cmd("highlight! Folded guibg=#333333")
