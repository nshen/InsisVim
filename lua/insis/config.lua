---@class InsisUserConfig
---@field colorscheme? "tokyonight" | "nord" | "onedark" | "gruvbox" | "nightfox" | "nordfox" | "duskfox" | "dracula" builtin colorscheme
---@field max_highlight_line_count? number disable code hightlight on big file for performance default 10000
---@field enable_imselect? boolean auto switch your input method, default false  ---@see https://github.com/daipeihust/im-select
---@field enable_very_magic_search? boolean enable regexp very magic mode ---@see https://www.youtube.com/watch?v=VjOcINs6QWs
---@field fix_windows_clipboard? boolean fix yank problem on windows WSL2 ---@see  https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows
---@field keys? InsisCommonkeys common keymappings
---@field s_windows? InsisSWindowConfig enabled by default
---@field s_tab? InsisSTabConfig disabled by default
---@field cmp? InsisCMPConfig Completion user config
---@field notify? InsisNotifyConfig nvim-notify plugin user config
---@field nvimTree? InsisNvimTreeConfig nvim-tree plugin user config
---@field bufferLine? InsisBufferLineConfig bufferline.nvim plugin user config
---@field telescope? InsisTelescopeConfig telescope.nvim plugin user config
---@field surround? InsisSurroundConfig nvim-surround plugin user config
---@field venn? InsisVENNConfig venn.nvim plugin user config
---@field zen? InsisZenConfig zen-mode.nvim plugin user config
---@field comment? InsisCommentConfig Comment.nvim plugin user config
---@field toggleterm? InsisToggleTermConfig toggleterm.nvim plugin user config
---@field copilot_chat? InsisCopilotChatConfig
---@field codecompanion? InsisCodecompanionConfig
---@field neotest? InsisNeotestConfig neotest plugin user config
---@field lsp? InsisLSPConfig LSP common config
---@field dap? InsisDAPConfig DAP common config
---@field frontend? InsisFrontendConfig Frontend development user config
---@field clangd? InsisClangdConfig Clangd user config
---@field golang? InsisGolangConfig Golang development user config
---@field lua? InsisLuaConfig Lua development user config
---@field rust? InsisRustConfig Rust development user config
---@field bash? InsisBashConfig sh development user config
---@field python? InsisPythonConfig python development user config
---@field ruby? InsisRubyConfig ruby development user config
---@field json? InsisJsonConfig Json user config
---@field markdown? InsisMarkdownConfig
---@field toml? InsisTomlConfig Toml user config
---@field yaml? InsisYamlConfig Yaml user config
---@field docker? InsisDockerConfig Docker user config
---@field solidity? InsisSolidityConfig
---@field java? InsisJavaConfig
---@field git? InsisGitConfig git user config
---@field mirror? InsisMirrorConfig mirror config
local InsisUserConfig = {

  colorscheme = "tokyonight",
  max_highlight_line_count = 5000,
  enable_imselect = false,
  enable_very_magic_search = false,
  fix_windows_clipboard = false,

  ---@class InsisCommonkeys
  ---@field leader_key? string
  ---@field n_save? string
  ---@field n_force_quit? string
  ---@field n_v_5j? string
  ---@field n_v_5k? string
  ---@field n_v_10k? string
  ---@field n_v_10j? string
  ---@field terminal_to_normal? string
  keys = {
    leader_key = " ",
    -- quick save / quite
    n_save = "<leader>w", -- :w
    n_force_quit = "<leader>q", -- :qa!
    -- quick move
    n_v_5j = "<C-j>",
    n_v_5k = "<C-k>",
    n_v_10k = "<C-u>",
    n_v_10j = "<C-d>",
    terminal_to_normal = "<Esc>",
  },

  ---------------------------
  -- Buffer & Window & Tab --
  ---------------------------

  ---@class InsisBufferLineConfig
  ---@field enable? boolean
  ---@field keys? {prev:string, next:string, close:string, close_left:string, close_right:string, close_others:string, close_pick:string}
  bufferLine = {
    enable = true,
    keys = {
      -- left / right cycle
      prev = "<C-h>",
      next = "<C-l>",
      -- close current buffer
      close = "<C-w>",
      -- close = "<leader>bc",
      -- close all left / right tabs
      close_left = "<leader>bh",
      close_right = "<leader>bl",
      -- close all other tabs
      close_others = "<leader>bo",
      close_pick = "<leader>bp",
    },
  },

  ---@class InsisSWindowConfig
  ---@field enable? boolean
  ---@field keys? {split_vertically:string, split_horizontally:string, close:string, close_others:string, jump_left:string[], jump_right:string[], jump_up:string[], jump_down:string[], width_decrease:string, width_increase:string, height_decrease:string, height_increase:string, size_equal:string}
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

  ---@class InsisSTabConfig
  ---@field enable? boolean
  ---@field keys? {split:string, prev:string, next:string, first:string, last:string, close:string}
  s_tab = {
    enable = false,
    keys = {
      split = "ts",
      prev = "th",
      next = "tl",
      first = "tj",
      last = "tk",
      close = "tc",
    },
  },

  ---@class InsisCMPConfig
  ---@field enable? boolean
  ---@field copilot? boolean
  ---@field codeium? boolean
  ---@field keys? {confirm:string, select_next_item:string, select_prev_item:string, scroll_doc_up:string, scroll_doc_down:string, complete:string, abort:string, snip_jump_next:string, snip_jump_prev:string, snip_next_choice:string, snip_prev_choice:string}
  cmp = {
    enable = true,
    -- enable copilot cmp
    copilot = false,
    -- run ':Copilot auth' for the first time
    codeium = false,
    -- run `:Codeium Auth ` for the first time
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

  ---@class InsisNotifyConfig
  ---@field enable? boolean
  ---@field timeout? number
  ---@field stages? 'fade'|'static'|'slide'
  ---@field render? 'default'|'minimal'|'simple'|'compact'|'wrapped-compact'
  notify = {
    enable = true,
    timeout = 3000,
    stages = "fade",
    render = "wrapped-compact",
  },

  ---@class InsisNvimTreeConfig
  ---@field enable? boolean
  ---@field keys? {toggle:string[], refresh:string, edit:string[], close:string, system_open:string, vsplit:string, split:string, tabnew:string, parent_node:string, first_sibling:string, last_sibling:string, cd:string, dir_up:string, toggle_git_ignored:string, toggle_dotfiles:string, toggle_custom:string, create:string, remove:string, rename:string, cut:string, copy:string, paste:string, copy_name:string, copy_path:string, copy_absolute_path:string, toggle_file_info:string}
  nvimTree = {
    enable = true,
    keys = {
      toggle = { "<A-m>", "<leader>m" },
      refresh = "R",
      -- open / close --
      edit = { "o", "<2-LeftMouse>" },
      close = "<BS>", -- close parent folder
      system_open = "<CR>",
      vsplit = "sv",
      split = "sh",
      tabnew = "st",
      -- movement --
      parent_node = "P",
      first_sibling = "K",
      last_sibling = "J",
      cd = ">",
      dir_up = "<",
      -- file toggle --
      toggle_git_ignored = "i", --.gitignore (git enable)
      toggle_dotfiles = ".", -- Hide (dotfiles)
      toggle_custom = "u", -- togglle custom config
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
      toggle_file_info = "gh",
    },
  },

  ---@class InsisTelescopeConfig
  ---@field enable? boolean
  ---@field keys? {find_files:string[], live_grep:string, live_grep_args:string, move_selection_next:string, move_selection_previous:string, cycle_history_next:string, cycle_history_prev:string, close:string, preview_scrolling_up:string, preview_scrolling_down:string}
  telescope = {
    enable = true,
    keys = {
      find_files = { "<C-p>", "ff" },
      live_grep = "<C-f>",
      -- super find  "xx" -tmd ---@see telescope-live-grep-args.nvim
      live_grep_args = "sf",
      -- up and down
      move_selection_next = "<C-j>",
      move_selection_previous = "<C-k>",
      -- history
      cycle_history_next = "<Down>",
      cycle_history_prev = "<Up>",
      -- close window
      close = "<esc>",
      -- scrolling in preview window
      preview_scrolling_up = "<C-u>",
      preview_scrolling_down = "<C-d>",
    },
  },

  ---@class InsisSurroundConfig
  ---@field enable? boolean
  ---@field keys? {normal:string, normal_cur:string, delete:string, change:string, visual:string, visual_line:string, insert:any, insert_line:any, normal_line:any, normal_cur_line:any}
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

  ---@class InsisVENNConfig
  ---@field enable? boolean
  ---@field keys? {toggle:string, up:string, down:string, left:string, right:string, draw_box:string}
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

  ---@class InsisZenConfig
  ---@field enable? boolean
  ---@field keys? {toggle:string}
  zen = {
    enable = true,
    keys = {
      toggle = "<leader>z",
    },
  },

  ---@class InsisCommentConfig
  ---@field enable? boolean
  ---@field toggler? {line:string, block:string}
  ---@field opleader? {line:string, block:string}
  comment = {
    enable = true,
    -- normal mode
    toggler = {
      line = "gcc", -- line comment
      block = "gbc", -- block comment
    },
    -- visual mode
    opleader = {
      line = "gc",
      block = "gb",
    },
  },

  ---@class InsisToggleTermConfig
  ---@field enable? boolean
  ---@field toggle_float_window? string
  ---@field toggle_float_window_command? string|nil
  ---@field toggle_side_window? string
  ---@field toggle_side_window_command? string|nil
  ---@field toggle_bottom_window? string
  ---@field toggle_bottom_window_command? string|nil
  toggleterm = {
    -- enable 3 builtin terminal <leader>t a/b/c
    enable = true,
    toggle_float_window = "<leader>ta",
    toggle_float_window_command = nil,
    toggle_side_window = "<leader>tb",
    toggle_side_window_command = nil,
    toggle_bottom_window = "<leader>tc",
    toggle_bottom_window_command = nil,
  },

  ---@class InsisCopilotChatConfig
  ---@field enable? boolean
  ---@field keys? {quick_chat:string, prompt_actions:string, help_actions:string}
  copilot_chat = {
    enable = false,
    keys = {
      -- Code Chat
      quick_chat = "<leader>cc",
      -- Code Prompt
      prompt_actions = "<leader>cp",
      -- Code Help
      help_actions = "<leader>ch",
    },
  },

  ---@class InsisCodecompanionConfig
  ---@field enable? boolean
  ---@field keys? {quick_chat:string, prompt_actions:string, help_actions:string}
  codecompanion = {
    enable = true,
    keys = {
      -- Code Chat
      toggle_chat = "<leader>cc",
      -- Code Prompt
      prompt_actions = "<leader>cp",
    },
  },

  ------------------------------------
  -- shared LSP keys
  ------------------------------------

  ---@class InsisLSPConfig
  ---@field definition? string
  ---@field implementation? string
  ---@field references? string
  ---@field hover? string
  ---@field call_in? string
  ---@field call_out? string
  ---@field rename? string
  ---@field code_action? string
  ---@field format? string
  ---@field open_float? string
  ---@field goto_next? string
  ---@field goto_prev? string
  lsp = {
    -- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
    definition = "gd",
    -- Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
    implementation = "gi",
    -- Lists LSP references for word under the cursor
    references = "gr",
    -- Displays hover information
    hover = "gh",
    -- Lists LSP incoming calls for word under the cursor
    call_in = "gci",
    -- Lists LSP outgoing calls for word under the cursor
    call_out = "gco",
    -- Rename variable under the cursor
    rename = "<leader>rn",
    -- Popup code action
    code_action = "<leader>ca",
    -- Format the current buffer
    format = "<leader>f",

    ----- Diagnostic ------

    -- Show diagnostics in a floating window.
    open_float = "gp",
    -- Move to the next diagnostic.
    goto_next = "gj",
    -- Move to the previous diagnostic.
    goto_prev = "gk",
  },

  ------------------------------------
  -- shared DAP keys
  ------------------------------------

  ---@class InsisDAPConfig
  ---@field continue? string
  ---@field terminate? string
  ---@field step_over? string
  ---@field step_into? string
  ---@field step_out? string
  ---@field toggle_breakpoint? string
  ---@field clear_breakpoints? string
  ---@field eval? string
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

  ---@class InsisNeotestConfig
  ---@field toggle? string
  ---@field run? string
  ---@field run_file? string
  ---@field run_dap? string
  ---@field run_stop? string
  ---@field output_open? string
  neotest = {
    toggle = "<leader>nt",
    run = "<leader>nr",
    run_file = "<leader>nf",
    run_dap = "<leader>nd",
    run_stop = "<leader>ns",
    output_open = "<leader>gh",
  },

  ------------------------------------
  -- Languages config
  ------------------------------------

  ---@class InsisFrontendConfig
  ---@field enable? boolean
  ---@field linter? "eslint" | false
  ---@field formatter? "prettier" | "ts_ls" | false
  ---@field format_on_save? boolean
  ---@field indent? number
  ---@field cspell? boolean
  ---@field tailwindcss? boolean
  ---@field prisma? boolean
  ---@field vue? boolean
  frontend = {
    enable = false,
    linter = "eslint", -- :EslintFixAll command added
    formatter = "ts_ls",
    format_on_save = false,
    indent = 2,
    cspell = false,
    tailwindcss = true,
    prisma = false,
    -- vue will take over typescript lsp
    vue = false,
  },

  ---@class InsisClangdConfig
  ---@field enable? boolean
  ---@field lsp? string
  ---@field formatter? string
  ---@field format_on_save? boolean
  ---@field indent? number
  clangd = {
    enable = false,
    lsp = "clangd",
    -- linter = "clangd-tidy",
    formatter = "clang-format",
    format_on_save = false,
    indent = 4,
  },

  ---@class InsisGolangConfig
  ---@field enable? boolean
  ---@field lsp? string
  ---@field linter? string
  ---@field formatter? string
  ---@field format_on_save? boolean
  ---@field indent? number
  golang = {
    enable = false,
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = false,
    indent = 4,
  },

  ---@class InsisLuaConfig
  ---@field enable? boolean
  ---@field lsp? string
  ---@field formatter? string
  ---@field format_on_save? boolean
  ---@field indent? number
  lua = {
    enable = true,
    lsp = "lua_ls",
    formatter = "stylua",
    format_on_save = true,
    indent = 2,
  },

  ---@class InsisRustConfig
  ---@field enable? boolean
  ---@field lsp? string
  ---@field formatter? string
  ---@field format_on_save? boolean
  ---@field indent? number
  rust = {
    enable = false,
    lsp = "rust_analyzer",
    -- rustup component add rustfmt
    formatter = "rustfmt",
    format_on_save = false,
    indent = 4,
  },

  ---@class InsisBashConfig
  bash = {
    enable = false,
    lsp = "bashls",
    --  brew install shfmt
    formatter = "shfmt",
    format_on_save = false,
    indent = 4,
  },

  ---@class InsisPythonConfig
  ---@field enable? boolean
  ---@field lsp? string
  ---@field formatter? string
  ---@field format_on_save? boolean
  ---@field indent? number
  python = {
    enable = false,
    -- can be pylsp or pyright
    lsp = "pylsp",
    -- pip install black
    -- asdf reshim python
    formatter = "black",
    format_on_save = false,
    indent = 4,
  },

  ---@class InsisRubyConfig
  ruby = {
    enable = false,
    lsp = "ruby_ls",
    -- gem install rubocop
    formatter = "rubocop",
    format_on_save = false,
    indent = 2,
  },

  ---@class InsisJsonConfig
  ---@field enable? boolean
  ---@field lsp? string
  ---@field formatter? "jsonls" | "prettier"
  ---@field format_on_save? boolean
  ---@field indent? number
  json = {
    enable = false,
    lsp = "jsonls",
    ---@type "jsonls" | "prettier"
    formatter = "jsonls",
    format_on_save = false,
    indent = 2,
  },

  ---@class InsisMarkdownConfig
  ---@field enable? boolean
  ---@field mkdnflow? {next_link:string, prev_link:string, next_heading:string, prev_heading:string, go_back:string, follow_link:string, toggle_item:string}
  ---@field formatter? string
  ---@field format_on_save? boolean
  ---@field wrap? boolean
  ---@field theme? "dark"|"light"
  markdown = {
    enable = false,
    mkdnflow = {
      next_link = "gn",
      prev_link = "gp",
      next_heading = "gj",
      prev_heading = "gk",
      go_back = "<C-o>",
      follow_link = "gd",
      toggle_item = "tt",
    },
    formatter = "prettier",
    format_on_save = false,
    wrap = true,
    ---@type "dark" | "light"
    theme = "dark",
  },

  ---@class InsisTomlConfig
  toml = {
    enable = false,
    lsp = "taplo",
    indent = 2,
  },

  ---@class InsisYamlConfig
  yaml = {
    enable = false,
    lsp = "yamlls",
    ---@type "prettier" | false
    formatter = "prettier",
    format_on_save = false,
    indent = 2,
  },

  ---@class InsisDockerConfig
  ---@field enable? boolean
  ---@field lsp? string
  ---@field indent? number
  docker = {
    enable = false,
    lsp = "dockerls",
    indent = 2,
  },

  ---@class InsisSolidityConfig
  ---@field enable? boolean
  ---@field linter? "solhint"|false
  ---@field format_on_save? boolean
  ---@field indent? number
  solidity = {
    enable = false,
    ---@type "solhint" | false
    linter = "solhint",
    format_on_save = false,
    indent = 4,
  },

  ---@class InsisJavaConfig
  ---@field enable? boolean
  ---@field indent? number
  java = {
    enable = false,
    indent = 4,
  },

  ---@class InsisGitConfig
  ---@field enable? boolean
  ---@field code_actions? string
  ---@field signcolumn? boolean
  ---@field numhl? boolean
  ---@field linehl? boolean
  ---@field word_diff? boolean
  ---@field current_line_blame? boolean
  git = {
    enable = true,
    code_actions = "gitsigns",
    -- sign display
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  },

  ---@class InsisMirrorConfig
  ---@field treesitter? string|false
  ---@field lsp? string  -- TODO
  ---@field dap? string   -- TODO
  mirror = {
    -- treesitter = "https://github.com/",
    treesitter = false,
    -- TODO: LSP DAP mirror config
    -- carefully change these value
  },
}

return InsisUserConfig
