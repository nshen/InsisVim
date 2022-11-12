local treesitter = pRequire("nvim-treesitter.configs")
local cfg = require("insis").config

if treesitter then
  -- get parsers from config file
  local getEnsureInstalled = function(config)
    local parserSet = { json = true, lua = true }

    if config.frontend and config.frontend.enable then
      for _, value in pairs(config.frontend.highlight) do
        parserSet[value] = true
      end
    end

    if config.go and config.golang.enable then
      parserSet["go"] = true
    end

    if config.rust and config.rust.enable then
      parserSet["rust"] = true
    end

    if config.markdown and config.markdown.enable then
      parserSet["markdown"] = true
    end

    local ensureInstalled = {}
    for key, _ in pairs(parserSet) do
      table.insert(ensureInstalled, key)
    end
  end

  pRequire("nvim-treesitter.install").prefer_git = true

  if cfg.mirror.treesitter then
    for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
      config.install_info.url = config.install_info.url:gsub("https://github.com/", cfg.mirror.treesitter)
    end
  end

  treesitter.setup({
    sync_install = false,
    -- language parser
    -- :TSInstallInfo
    -- ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "markdown" },
    -- ensure_installed = "maintained",
    ensure_installed = getEnsureInstalled(cfg),

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(_, bufnr) -- Disable in large buffers
        return vim.api.nvim_buf_line_count(bufnr) > cfg.disalbe_highlight_line_count
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
    -- enable =
    indent = {
      enable = true,
    },
    -- p00f/nvim-ts-rainbow
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = 10000, -- Do not enable for files with more than n lines, int
      colors = {
        "#95ca60",
        "#ee6985",
        "#D6A760",
        "#7794f4",
        "#b38bf5",
        "#7cc7fe",
      },
      -- termcolors = { } -- table of colour name strings
    },
    -- language comments
    -- Also see :comment.lua
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
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
      highlight_current_scope = { enable = true },
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

  -- Folding mode
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldenable = false
  vim.opt.foldtext = "v:lua.require('insis.utils.simple_fold').simple_fold()"
  -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
  -- vim.opt.foldlevel = 99
end
