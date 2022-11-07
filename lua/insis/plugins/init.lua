-- NOTE: Do not use requires in plugin
return {
  -- Packer can manage itself
  { "wbthomason/packer.nvim" },
  -------------------------- plugins -------------------------------------------
  -- requires
  { "kyazdani42/nvim-web-devicons" },
  { "moll/vim-bbye" },
  { "nvim-lua/plenary.nvim" },
  -- ("lewis6991/impatient.nvim")

  -- nvim-notify
  {
    "rcarriga/nvim-notify",
    config = function()
      require("insis.plugins.nvim-notify")
    end,
  },
  -- nvim-tree
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("insis.plugins.nvim-tree")
    end,
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("insis.plugins.bufferline")
    end,
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("insis.plugins.lualine")
    end,
  },

  -- telescope
  -- telescope extensions
  { "LinArcX/telescope-env.nvim" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    -- opt = true,
    -- cmd = "Telescope",
    config = function()
      require("insis.plugins.telescope")
    end,
  },

  -- alpha.nvim
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("insis.plugins.alpha").config)
    end,
  },

  -- treesitter
  { "p00f/nvim-ts-rainbow" },
  { "JoosepAlviste/nvim-ts-context-commentstring" }, -- comment
  { "windwp/nvim-ts-autotag" },
  { "nvim-treesitter/nvim-treesitter-refactor" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("insis.plugins.treesitter")
    end,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("insis.plugins.comment")
    end,
  },
  -- indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("insis.plugins.indent-blankline")
    end,
  },

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugin-config.toggleterm")
    end,
  },

  -- surround
  -- ({
  --   "ur4ltz/surround.nvim",
  --   config = function()
  --     require("plugin-config.surround")
  --   end,
  -- })

  -- nvim-surround
  {
    "kylechui/nvim-surround",
    config = function()
      require("plugin-config.nvim-surround")
    end,
  },

  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin-config.nvim-autopairs")
    end,
  },

  -- fidget.nvim
  {
    "j-hui/fidget.nvim",
    config = function()
      require("plugin-config.fidget")
    end,
  },

  -- todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    config = function()
      require("plugin-config.todo-comments")
    end,
  },

  -- mkdnflow.nvim
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown" },
    commit = "739b8b93530adbd5dfb2d3abff66752637442d41",
    config = function()
      require("plugin-config.mkdnflow")
    end,
  },

  -- venn 画图
  {
    "jbyuki/venn.nvim",
    config = function()
      require("plugin-config.venn")
    end,
  },

  -- zen mode
  {
    "folke/zen-mode.nvim",
    config = function()
      require("plugin-config.zen-mode")
    end,
  },
  --------------------- LSP --------------------
  -- installer
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  -- Lspconfig
  { "neovim/nvim-lspconfig" },
  -- 补全引擎
  { "hrsh7th/nvim-cmp" },
  -- Snippet 引擎
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  -- 补全源
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/cmp-nvim-lsp" }, -- { name = nvim_lsp }
  { "hrsh7th/cmp-buffer" }, -- { name = 'buffer' },
  { "hrsh7th/cmp-path" }, -- { name = 'path' }
  { "hrsh7th/cmp-cmdline" }, -- { name = 'cmdline' }
  { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- { name = 'nvim_lsp_signature_help' }
  -- 常见编程语言代码段
  { "rafamadriz/friendly-snippets" }, -- UI 增强
  { "onsails/lspkind-nvim" },
  { "tami5/lspsaga.nvim" },
  -- 代码格式化
  { "mhartington/formatter.nvim" },
  { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" },
  -- TypeScript 增强
  { "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" },
  { "jose-elias-alvarez/typescript.nvim" },
  -- Lua 增强
  { "folke/neodev.nvim" },
  -- JSON 增强
  { "b0o/schemastore.nvim" },
  -- Rust 增强
  { "simrat39/rust-tools.nvim" },
  --------------------- colorschemes --------------------
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    config = function()
      require("plugin-config.tokyonight")
    end,
  },
  -- OceanicNext
  -- { "mhartington/oceanic-next", event = "VimEnter" }

  -- gruvbox
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   requires = { "rktjmp/lush.nvim" },
  -- }

  -- zephyr
  -- ("glepnir/zephyr-nvim")

  -- nord
  -- ("shaunsingh/nord.nvim")

  -- onedark
  -- ("ful1e5/onedark.nvim")

  -- nightfox
  -- ("EdenEast/nightfox.nvim")

  -------------------------------------------------------
  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugin-config.gitsigns")
    end,
  },
  -- vimspector
  {
    "puremourning/vimspector",
    cmd = { "VimspectorInstall", "VimspectorUpdate" },
    fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
    config = function()
      require("dap.vimspector")
    end,
  },
  ----------------------------------------------
  -- nvim-dap
  { "mfussenegger/nvim-dap" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "rcarriga/nvim-dap-ui" },

  -- node
  {
    "mxsdev/nvim-dap-vscode-js",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      -- NOTICE: require dap config
      require("insis.dap.nvim-dap.config.vscode-js")
    end,
  },

  -- go
  { "leoluz/nvim-dap-go" },

  --[[ not work

  {
  "mfussenegger/nvim-dap-python",
  requires = { "mfussenegger/nvim-dap" },
  config = function()
  require("dap-python").setup("/rs/nn/.local/share/nvim/mason/bin/debugpy")
  end,
  }

    --]]

  -- ("jbyuki/one-small-step-for-vimkind")
  --[[ ("dstein64/vim-startuptime") ]]
}
