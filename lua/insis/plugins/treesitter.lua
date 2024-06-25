local treesitter = pRequire("nvim-treesitter.configs")
local cfg = require("insis").config

local treesitterQuery = pRequire("nvim-treesitter.query")
if not treesitterQuery then
  return
end
if treesitter then
  pRequire("nvim-treesitter.install").prefer_git = true

  treesitter.setup({
    sync_install = false,
    -- :TSInstallInfo
    -- ensure_installed = "maintained",
    ensure_installed = require("insis.env").getTSEnsureList(),

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(lang, bufnr)
        if vim.bo.filetype == "help" then
          return true
        else
          return vim.api.nvim_buf_line_count(bufnr) > cfg.max_highlight_line_count
        end
      end,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "=",
        node_incremental = "=",
        node_decremental = "-",
        scope_incremental = "<TAB>",
      },
    },

    indent = {
      enable = true,
    },

    -- https://github.com/windwp/nvim-ts-autotag
    autotag = {
      enable = true,
    },
    -- https://github.com/RRethy/nvim-treesitter-endwise
    endwise = {
      enable = true,
    },
    -- nvim-treesitter/nvim-treesitter-refactor
    refactor = {
      highlight_definitions = {
        enable = true,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = false },
    },
    -- nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "V",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["ml"] = "@parameter.inner",
        },
        swap_previous = {
          ["mh"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["gnf"] = "@function.outer",
          ["gnc"] = "@class.outer",
        },
        goto_previous_start = {
          ["gpf"] = "@function.outer",
          ["gpc"] = "@class.outer",
        },
        -- goto_previous_end = {
        --   ["[M"] = "@function.outer",
        --   ["[]"] = "@class.outer",
        -- },
        -- goto_next_end = {
        --   ["]M"] = "@function.outer",
        --   ["]["] = "@class.outer",
        -- },
      },
    },
  })

  -- if cfg.mirror.treesitter then
  --   for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
  --     config.install_info.url = config.install_info.url:gsub("https://github.com/", cfg.mirror.treesitter)
  --   end
  -- end
end
