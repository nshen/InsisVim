local nvimTree = pRequire("nvim-tree")
local cfg = require("insis").config.nvimTree

if nvimTree and cfg and cfg.enable then
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  keymap("n", cfg.keys.toggle, "<CMD>NvimTreeToggle<CR>")
  local list_keys = {

    { key = cfg.keys.refresh, action = "refresh" },

    -- open / close --
    { key = cfg.keys.edit, action = "edit" },
    { key = cfg.keys.close, action = "close_node" },
    { key = cfg.keys.system_open, action = "system_open" },
    { key = cfg.keys.vsplit, action = "vsplit" },
    { key = cfg.keys.split, action = "split" },
    { key = cfg.keys.tabnew, action = "tabnew" },

    -- movement ---------------
    { key = cfg.keys.parent_node, action = "parent_node" },
    { key = cfg.keys.cd, action = "cd" },
    { key = cfg.keys.dir_up, action = "dir_up" },
    { key = cfg.keys.prev_sibling, action = "prev_sibling" },
    { key = cfg.keys.next_sibling, action = "next_sibling" },
    { key = cfg.keys.first_sibling, action = "first_sibling" },
    { key = cfg.keys.last_sibling, action = "last_sibling" },

    -- file toggle --
    { key = cfg.keys.toggle_git_ignored, action = "toggle_git_ignored" },
    { key = cfg.keys.toggle_dotfiles, action = "toggle_dotfiles" },
    { key = cfg.keys.toggle_custom, action = "toggle_custom" },
    { key = cfg.keys.toggle_file_info, action = "toggle_file_info" },

    ------ file operation ----------
    { key = cfg.keys.create, action = "create" },
    { key = cfg.keys.remove, action = "remove" },
    { key = cfg.keys.rename, action = "rename" },
    { key = cfg.keys.copy, action = "copy" },
    { key = cfg.keys.cut, action = "cut" },
    { key = cfg.keys.paste, action = "paste" },
    { key = cfg.keys.copy_name, action = "copy_name" },
    { key = cfg.keys.copy_path, action = "copy_path" },
    { key = cfg.keys.copy_absolute_path, action = "copy_absolute_path" },
    { key = cfg.keys.toggle_file_info, action = "toggle_file_info" },
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
    system_open = {
      -- NOTE: WSL need wsl-open
      -- npm install -g wsl-open
      -- https://github.com/4U6U57/wsl-open/
      cmd = isWSL() and "wsl-open" or "open",
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

  local api = require("nvim-tree.api")
  api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd("edit " .. file.fname)
  end)
end
