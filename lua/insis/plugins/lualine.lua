local lualine = pRequire("lualine")
-- local cfg = require("insis").config.lualine

if lualine then
  lualine.setup({
    options = {
      -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
      theme = pRequire("insis").config.colorscheme or "tokyonight",
      component_separators = {
        left = "|",
        right = "|",
      },
      -- https://github.com/ryanoasis/powerline-extra-symbols
      section_separators = {
        left = " ",
        right = "",
      },
      globalstatus = true,
    },
    extensions = { "nvim-tree" },
    sections = {
      lualine_c = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_x = {
        "filesize",
        {
          "fileformat",
          -- symbols = {
          --   unix = '', -- e712
          --   dos = '', -- e70f
          --   mac = '', -- e711
          -- },
          symbols = {
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
          },
        },
        "encoding",
        "filetype",
      },
    },
  })
end
