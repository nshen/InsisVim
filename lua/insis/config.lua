-- Default user config
return {
  -- config_path = vim.fn.stdpath("config"),

  lock_plugin_commit = false,
  -- very magic mode
  -- https://www.youtube.com/watch?v=VjOcINs6QWs
  enable_very_magic_search = true,
  -- disable code hightlight on big file for performance
  disalbe_highlight_line_count = 10000,

  packer = {
    max_jobs = 20,
    clone_timeout = 100,

    -- default_url_format = "https://hub.fastgit.xyz/%s",
    -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
    -- default_url_format = "https://gitcode.net/mirrors/%s",
    -- default_url_format = "https://gitclone.com/github.com/%s",
    default_url_format = "https://github.com/%s",
  },

  notify = {
    enable = true,
    -- in millionsecond
    timeout = 3000,
    -- 'fade', 'static', 'slide'
    stages = "fade",
    -- 'defalut','minimal','simple'
    render = "minimal",
  },

  nvimTree = {

    enable = true,

    keys = {

      toggle = { "<A-m>", "<leader>m" },
      refresh = "R",

      -- open / close --
      edit = { "o", "<2-LeftMouse>" },
      close = "<BS>",
      system_open = "<CR>",
      vsplit = "sv",
      split = "sh",
      tabnew = "gh",

      -- movement --
      parent_node = "P",
      cd = "]",
      dir_up = "[",
      prev_sibling = "<",
      next_sibling = ">",
      first_sibling = "K",
      last_sibling = "J",

      -- file toggle --
      toggle_git_ignored = "i", --.gitignore (git enable)
      toggle_dotfiles = ".", -- Hide (dotfiles)
      toggle_custom = "u", -- togglle custom config
      toggle_file_info = "gh",

      -- file operate --
      create = "a",
      remove = "d",
      rename = "r",
      cut = "x",
      copy = "c",
      paste = "p",
      copy_name = "y",
      copy_path = "Y",
      copy_absolute_path = "gy",
    },
  },

  bufferLine = {

    enable = true,

    keys = {

      -- left / right cycle
      prev = "<C-h>",
      next = "<C-l>",

      -- close current buffer
      close = "<C-w>", -- close = "<leader>bc",

      -- close all left / right tabs
      close_left = "<leader>bh",
      close_right = "<leader>bl",

      -- close all other tabs
      close_others = "<leader>bo",
      close_pick = "<leader>bp",
    },
  },

  telescope = {

    enable = true,

    keys = {
      find_files = { "<C-p>", "ff" },
      live_grep = "<C-f>",
      live_grep_args = "sf", -- super find  "xx" -tmd

      -- 上下移动
      move_selection_next = "<C-j>",
      move_selection_previous = "<C-k>",
      -- move_selection_next = "<C-n>",
      -- move_selection_previous = "<C-p>",
      -- 历史记录
      cycle_history_next = "<Down>",
      cycle_history_prev = "<Up>",
      -- 关闭窗口
      -- close = "<C-c>",
      close = "<esc>",
      -- 预览窗口上下滚动
      preview_scrolling_up = "<C-u>",
      preview_scrolling_down = "<C-d>",
    },
  },

  -- super window
  -- will disable default s key

  s_windows = {

    enable = true,

    keys = {

      split_vertically = "sv",
      split_horizontally = "sh",
      -- close current
      close = "sc",
      -- close others
      close_others = "so",

      -- jump between windows
      jump_left = { "<A-h>", "<leader>h" },
      jump_right = { "<A-l>", "<leader>l" },
      jump_up = { "<A-k>", "<leader>k" },
      jump_down = { "<A-j>", "<leader>j" },

      -- control windows size
      width_decrease = "s,",
      width_increase = "s.",
      height_decrease = "sj",
      height_increase = "sk",
      size_equal = "s=",
    },
  },

  -- super tab
  s_tab = {

    enable = true,

    keys = {
      split = "ts",
      prev = "th",
      next = "tl",
      first = "tj",
      last = "tk",
      close = "tc",
    },
  },

  surround = {

    enable = true,

    keys = {
      -- you surround
      normal = "ys",
      -- you surround line
      normal_cur = "yss",
      delete = "ds",
      change = "cs",
      -- visual mode
      visual = "s",
      visual_line = "gs",
      -- disable
      insert = false,
      insert_line = false,
      normal_line = false,
      normal_cur_line = false,
    },
  },

  ------------------------------------
  -- Languages

  lsp = {
    -- jumps to the declaration
    definition = "gd",
    -- jumps to the declaration, many servers do not implement this method
    declaration = false,
    -- displays hover information
    hover = "gh",
    -- lists all the implementations
    implementation = "gi",
    -- lists all the references to the symbol
    references = "gr",

    rename = "<leader>rn",
    code_action = "<leader>ca",
    format = "<leader>f",
    -- diagnostic
    open_flow = "gp",
    goto_next = "gj",
    goto_prev = "gk",
    list = "gl",
  },

  dap = {

    -- start, stop
    continue = "<leader>dc",
    terminate = "<leader>de",

    --  stepOver, stepInto, stepOut,
    step_over = "<leader>dj",
    step_into = "<leader>di",
    step_out = "<leader>do",

    -- breakpoints
    toggle_breakpoint = "<leader>dt",
    clear_breakpoints = "<leader>dT",

    eval = "<leader>dh",
  },

  ------------------------------------
  -- shared Test keys
  ------------------------------------

  ---@class NeotestConfig
  neotest = {
    toggle = "<leader>nt",
    run = "<leader>nr",
    run_file = "<leader>nf",
    run_dap = "<leader>nd",
    run_stop = "<leader>ns",
    output_open = "<leader>gh",
  },

  frontend = {
    enable = true,
    -- treesitter code highlight
    highlight = { "html", "css", "javascript", "typescript", "tsx", "vue" },
    -- mason lsp ensure list
    lsp = { "tsserver", "tailwindcss", "cssls", "emmet_ls", "html" },
    -- null-ls ensure list
    -- npm install -g eslint_d
    linter = "eslint_d",
    code_actions = "eslint_d",
    formatter = "eslint_d", -- eslint_d | prettier
    -- extra lsp command provided by typescript.nvim
    typescript = {
      format_on_save = false,
      keys = {
        ts_organize = "gs",
        ts_rename_file = "gR",
        ts_add_missing_import = "ga",
        ts_remove_unused = "gu",
        ts_fix_all = "gf",
        ts_goto_source = "gD",
      },
    },
  },

  golang = {
    enable = true,
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = true,
  },

  lua = {
    enable = false,
    lsp = "sumneko_lua",
    formatter = "stylua",
    format_on_save = true,
  },

  rust = {
    enable = true,
    lsp = "rust_analyzer",
    -- rustup component add rustfmt
    formatter = "rustfmt",
    format_on_save = false,
  },

  sh = {
    enable = true,
    lsp = "bashls",
    --  brew install shfmt
    formatter = "shfmt",
    format_on_save = false,
  },

  python = {
    enable = true,
    -- can be pylsp or pyright
    lsp = "pylsp",
    -- pip install black
    -- asdf reshim python
    formatter = "black",
    format_on_save = false,
  },

  ruby = {
    enable = false,
    lsp = "ruby_ls",
    -- gem install rubocop
    formatter = "rubocop",
    format_on_save = false,
  },

  json = {
    enable = true,
    lsp = "jsonls",
    -- npm install -g fixjson
    formatter = "fixjson",
    format_on_save = false,
  },

  markdown = {
    enable = true,
    mkdnflow = {
      next_link = "gn",
      prev_link = "gp",
      next_heading = "gj",
      prev_heading = "gk",
      go_back = "<C-o>",
      follow_link = "gd",
      toggle_item = "tt",
    },
  },

  toml = {
    enable = true,
    lsp = "taplo",
  },

  yaml = {
    enable = true,
    lsp = "yamlls",
    formatter = "prettier",
    format_on_save = false,
  },

  git = {
    enable = true,
    code_actions = "gitsigns",
    -- sign display
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  },

  -- TODO: mirror
  mirror = {
    treesitter = "https://github.com/",
    packer = "https://github.com/",
  },

  venn = {

    enable = true,

    keys = {
      -- toggle keymappings for venn using <leader>v
      toggle = "<leader>v",
      up = "K",
      down = "J",
      left = "H",
      right = "L",
      -- draw a box by pressing "f" with visual selection
      draw_box = "f",
    },
  },

  zen = {
    enable = true,
    keys = {
      toggle = "<leader>z",
    },
  },

  cmp = {
    enable = true,

    keys = {
      confirm = "<CR>",
      select_next_item = "<C-j>",
      select_prev_item = "<C-k>",
      scroll_doc_up = "<C-u>",
      scroll_doc_down = "<C-d>",
      complete = "<A-.>",
      abort = "<A-,>",

      -- luasnip
      snip_jump_next = "<C-l>",
      snip_jump_prev = "<C-h>",
      snip_next_choice = "<C-j>",
      snip_prev_choice = "<C-k>",
    },
  },

  keys = {

    leader_key = " ",
    -- no highlight
    nohl = "<ESC><ESC>",

    -- quick save / quite
    n_save = "<leader>w", -- :w
    n_save_quit = "<leader>wq", --:wq
    n_save_all = "<leader>wa", -- :wa
    -- n_save_all_quit = "<leader>qa", -- :wqa
    n_force_quit = "<leader>q", -- :qa!

    -- quick move
    n_v_5j = "<C-j>",
    n_v_5k = "<C-k>",
    n_v_10k = "<C-u>",
    n_v_10j = "<C-d>",

    fold = {
      open = "zo",
      close = "zc",
    },

    terminal_to_normal = "<Esc>",
    -- TODO

    -- proxy
    -- im-select
  },

  comment = {
    enable = true,
    -- Normal 模式快捷键
    toggler = {
      line = "gcc", -- 行注释
      block = "gbc", -- 块注释
    },
    -- Visual 模式
    opleader = {
      line = "gc",
      bock = "gb",
    },
  },

  toggleterm = {
    enable = true,

    -- <leader>ta float terminal window
    toggle_window_A = "<leader>ta",
    toggle_window_A_command = nil,
    -- <leader>tb right side terminal window
    toggle_window_B = "<leader>tb",
    toggle_window_B_command = nil,
    -- <leader>tc bottom terminal window
    toggle_window_C = "<leader>tc",
    toggle_window_C_command = nil,
  },
}
