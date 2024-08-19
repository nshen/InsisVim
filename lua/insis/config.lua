---@class UserConfig
---@field colorscheme? "tokyonight" | "nord" | "onedark" | "gruvbox" | "nightfox" | "nordfox" | "duskfox" | "dracula" builtin colorscheme
---@field max_highlight_line_count? number disable code hightlight on big file for performance default 10000
---@field enable_imselect? boolean auto switch your input method, default false  ---@see https://github.com/daipeihust/im-select
---@field enable_very_magic_search? boolean enable regexp very magic mode ---@see https://www.youtube.com/watch?v=VjOcINs6QWs
---@field fix_windows_clipboard? boolean fix yank problem on windows WSL2 ---@see  https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows
---@field keys? Commonkeys common keymappings
---@field s_windows? SWindowConfig enabled by default
---@field s_tab? STabConfig disabled by default
---@field cmp? CMPConfig Completion user config
---@field notify? NotifyConfig nvim-notify plugin user config
---@field nvimTree? NvimTreeConfig nvim-tree plugin user config
---@field bufferLine? BufferLineConfig bufferline.nvim plugin user config
---@field telescope? TelescopeConfig telescope.nvim plugin user config
---@field surround? SurroundConfig nvim-surround plugin user config
---@field venn? VENNConfig venn.nvim plugin user config
---@field zen? ZenConfig zen-mode.nvim plugin user config
---@field comment? CommentConfig Comment.nvim plugin user config
---@field toggleterm? ToggleTermConfig toggleterm.nvim plugin user config
---@field neotest? NeotestConfig neotest plugin user config
---@field lsp? LSPConfig LSP common config
---@field dap? DAPConfig DAP common config
---@field frontend? FrontendConfig Frontend development user config
---@field clangd? ClangdConfig Clangd user config
---@field golang? GolangConfig Golang development user config
---@field lua? LuaConfig Lua development user config
---@field rust? RustConfig Rust development user config
---@field bash? BashConfig sh development user config
---@field python? PythonConfig python development user config
---@field ruby? RubyConfig ruby development user config
---@field json? JsonConfig Json user config
---@field markdown? MarkdownConfig
---@field toml? TomlConfig Toml user config
---@field yaml? YamlConfig Yaml user config
---@field docker? DockerConfig Docker user config
---@field solidity? SolidityConfig
---@field java? JavaConfig
---@field git? GitConfig git user config
---@field mirror? MirrorConfig mirror config

local UserConfig = {

  colorscheme = "tokyonight",
  max_highlight_line_count = 5000,
  enable_imselect = false,
  enable_very_magic_search = false,
  fix_windows_clipboard = false,

  ---@class Commonkeys
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

  ---@class BufferLineConfig
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

  ---@class SWindowConfig
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

  ---@class STabConfig
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

  ---@class CMPConfig
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
      copilot_panel = "<leader>cpp",
    },
  },

  ---@class NotifyConfig
  notify = {
    enable = true,
    ---@type number in millionsecond
    timeout = 3000,
    ---@type 'fade' | 'static' | 'slide'
    stages = "fade",
    ---@type  'default' | 'minimal' | 'simple' | 'compact' | 'wrapped-compact'
    render = "wrapped-compact",
  },

  ---@class NvimTreeConfig
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

  ---@class TelescopeConfig
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

  ---@class SurroundConfig
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

  ---@class VENNConfig
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

  ---@class ZenConfig
  zen = {
    enable = true,
    keys = {
      toggle = "<leader>z",
    },
  },

  ---@class CommentConfig
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

  ---@class ToggleTermConfig
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

  ------------------------------------
  -- shared LSP keys
  ------------------------------------

  ---@class LSPConfig
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

  ---@class DAPConfig
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

  ------------------------------------
  -- Languages config
  ------------------------------------

  ---@class FrontendConfig
  frontend = {
    enable = false,
    ---@type "eslint" | false
    linter = "eslint", -- :EslintFixAll command added
    ---@type false | "prettier" | "tsserver"
    formatter = "tsserver",
    format_on_save = false,
    indent = 4,
    cspell = false,
    tailwindcss = true,
    prisma = false,
    -- vue will take over typescript lsp
    vue = false,
    -- extra lsp command provided by typescript.nvim
    typescript = {
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

  ---@class ClangdConfig
  clangd = {
    enable = false,
    lsp = "clangd",
    -- linter = "clangd-tidy",
    formatter = "clang-format",
    format_on_save = false,
    indent = 4,
  },

  ---@class GolangConfig
  golang = {
    enable = false,
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = false,
    indent = 4,
  },

  ---@class LuaConfig
  lua = {
    enable = true,
    lsp = "lua_ls",
    formatter = "stylua",
    format_on_save = true,
    indent = 2,
  },

  ---@class RustConfig
  rust = {
    enable = false,
    lsp = "rust_analyzer",
    -- rustup component add rustfmt
    formatter = "rustfmt",
    format_on_save = false,
    indent = 4,
  },

  ---@class BashConfig
  bash = {
    enable = false,
    lsp = "bashls",
    --  brew install shfmt
    formatter = "shfmt",
    format_on_save = false,
    indent = 4,
  },

  ---@class PythonConfig
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

  ---@class RubyConfig
  ruby = {
    enable = false,
    lsp = "ruby_ls",
    -- gem install rubocop
    formatter = "rubocop",
    format_on_save = false,
    indent = 2,
  },

  ---@class JsonConfig
  json = {
    enable = false,
    lsp = "jsonls",
    ---@type "jsonls" | "prettier"
    formatter = "jsonls",
    format_on_save = false,
    indent = 2,
  },

  ---@class MarkdownConfig
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

  ---@class TomlConfig
  toml = {
    enable = false,
    lsp = "taplo",
    indent = 2,
  },

  ---@class YamlConfig
  yaml = {
    enable = false,
    lsp = "yamlls",
    ---@type "prettier" | false
    formatter = "prettier",
    format_on_save = false,
    indent = 2,
  },

  ---@class DockerConfig
  docker = {
    enable = false,
    lsp = "dockerls",
    indent = 2,
  },

  ---@class SolidityConfig
  solidity = {
    enable = false,
    ---@type "solhint" | false
    linter = "solhint",
    format_on_save = false,
    indent = 4,
  },

  ---@class JavaConfig
  java = {
    enable = false,
    indent = 4,
  },

  ---@class GitConfig
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

  ---@class MirrorConfig
  mirror = {
    -- treesitter = "https://github.com/",
    treesitter = false,
    packer = "https://github.com/",
    -- TODO: LSP DAP mirror config
    -- carefully change these value
  },
}

return UserConfig
