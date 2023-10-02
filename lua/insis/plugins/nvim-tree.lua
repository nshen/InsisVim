local nvimTree = pRequire("nvim-tree")
local cfg = require("insis").config.nvimTree

if nvimTree and cfg and cfg.enable then
  keymap("n", cfg.keys.toggle, "<CMD>NvimTreeToggle<CR>")
  local function on_attach(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    keymap("n", cfg.keys.refresh, api.tree.reload, opts("Refresh"))

    -- open / close --
    keymap("n", cfg.keys.edit, api.node.open.edit, opts("Open"))
    keymap("n", cfg.keys.close, api.node.navigate.parent_close, opts("Close Directory"))
    keymap("n", cfg.keys.system_open, api.node.run.system, opts("Run System"))
    keymap("n", cfg.keys.vsplit, api.node.open.vertical, opts("Open: Vertical Split"))
    keymap("n", cfg.keys.split, api.node.open.horizontal, opts("Open: Horizontal Split"))
    keymap("n", cfg.keys.tabnew, api.node.open.tab, opts("Open: New Tab"))

    -- movement --
    keymap("n", cfg.keys.parent_node, api.node.navigate.parent, opts("Parent Directory"))
    keymap("n", cfg.keys.last_sibling, api.node.navigate.sibling.last, opts("Last Sibling"))
    keymap("n", cfg.keys.first_sibling, api.node.navigate.sibling.first, opts("First Sibling"))
    keymap("n", cfg.keys.cd, api.tree.change_root_to_node, opts("CD"))
    keymap("n", cfg.keys.dir_up, api.tree.change_root_to_parent, opts("Up"))

    -- file toggle --
    keymap("n", cfg.keys.toggle_git_ignored, api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
    keymap("n", cfg.keys.toggle_dotfiles, api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
    keymap("n", cfg.keys.toggle_custom, api.tree.toggle_custom_filter, opts("Toggle Hidden"))

    -- file operate --
    keymap("n", cfg.keys.create, api.fs.create, opts("Create"))
    keymap("n", cfg.keys.remove, api.fs.remove, opts("Delete"))
    keymap("n", cfg.keys.rename, api.fs.rename, opts("Rename"))
    keymap("n", cfg.keys.copy, api.fs.copy.node, opts("Copy"))
    keymap("n", cfg.keys.cut, api.fs.cut, opts("Cut"))
    keymap("n", cfg.keys.paste, api.fs.paste, opts("Paste"))
    keymap("n", cfg.keys.copy_name, api.fs.copy.filename, opts("Copy Name"))
    keymap("n", cfg.keys.copy_path, api.fs.copy.relative_path, opts("Copy Relative Path"))
    keymap("n", cfg.copy_absolute_path, api.fs.copy.absolute_path, opts("Copy Absolute Path"))
    keymap("n", cfg.toggle_file_info, api.node.show_info_popup, opts("Info"))
  end
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  nvimTree.setup({
    on_attach = on_attach,
    update_focused_file = {
      enable = true,
      update_root = true,
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
      root_folder_label = false,
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
