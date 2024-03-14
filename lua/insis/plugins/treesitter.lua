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
      disable = function(_, bufnr) -- Disable in large buffers
        return vim.api.nvim_buf_line_count(bufnr) > cfg.max_highlight_line_count
      end,
    },

    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
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
        },
      },
      swap = {
        enable = false,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  })

  -- if cfg.mirror.treesitter then
  --   for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
  --     config.install_info.url = config.install_info.url:gsub("https://github.com/", cfg.mirror.treesitter)
  --   end
  -- end
end
