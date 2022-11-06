local nvimTree = pRequire("nvim-tree")
local cfg = require("insis").config.nvimTree

if nvimTree and cfg and cfg.enable then
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  keymap("n", cfg.keys.toggle, "<CMD>NvimTreeToggle<CR>")
  local list_keys = {
    {
      key = cfg.keys.edit,
      action = "edit",
    },
    {
      key = cfg.keys.system_open,
      action = "system_open",
    }, -- v分屏打开文件
    {
      key = cfg.keys.vsplit,
      action = "vsplit",
    }, -- h分屏打开文件
    {
      key = cfg.keys.split,
      action = "split",
    }, -- gitignore
    {
      key = cfg.keys.toggle_git_ignored,
      action = "toggle_git_ignored",
    }, -- Hide (dotfiles)
    {
      key = cfg.keys.toggle_dotfiles,
      action = "toggle_dotfiles",
    }, -- toggle filters > custom
    {
      key = cfg.keys.toggle_custom,
      action = "toggle_custom",
    },
    {
      key = cfg.keys.refresh,
      action = "refresh",
    }, -- 文件操作
    {
      key = cfg.keys.create,
      action = "create",
    },
    {
      key = cfg.keys.remove,
      action = "remove",
    },
    {
      key = cfg.keys.rename,
      action = "rename",
    },
    {
      key = cfg.keys.copy,
      action = "copy",
    },
    {
      key = cfg.keys.cut,
      action = "cut",
    },
    {
      key = cfg.keys.paste,
      action = "paste",
    },
    {
      key = cfg.keys.copy_name,
      action = "copy_name",
    },
    {
      key = cfg.keys.copy_path,
      action = "copy_path",
    },
    {
      key = cfg.keys.copy_absolute_path,
      action = "copy_absolute_path",
    },
    {
      key = cfg.keys.toggle_file_info,
      action = "toggle_file_info",
    },
    {
      key = cfg.keys.tabnew,
      action = "tabnew",
    }, -- 进入下一级
    {
      key = cfg.keys.cd,
      action = "cd",
    }, -- 进入上一级
    {
      key = cfg.keys.dir_up,
      action = "dir_up",
    },
  }

  nvimTree.setup({
    --automatically open the tree when running setup if startup buffer is a directory
    open_on_setup = true,
    disable_netrw = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    git = {
      enable = true,
      ignore = true,
    },
    filters = {
      -- hide dot files
      dotfiles = true,
      -- hide node_modules folder
      -- custom = { "node_modules" },
    },
    view = {
      width = 34,
      -- or 'right'
      side = "left",
      hide_root_folder = false,
      mappings = {
        custom_only = true,
        list = list_keys,
      },
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    actions = {
      open_file = {
        resize_window = true,
        quit_on_open = false,
      },
    },
    -- wsl install -g wsl-open
    -- https://github.com/4U6U57/wsl-open/
    system_open = {
      -- mac
      cmd = "open",
      -- TODO: windows
      -- cmd = "wsl-open",
    },
    renderer = {
      indent_markers = {
        enable = false,
        icons = {
          corner = "└ ",
          edge = "│ ",
          none = "  ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
      },
    },
  })
end
