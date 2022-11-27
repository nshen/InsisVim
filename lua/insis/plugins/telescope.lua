local telescope = pRequire("telescope")
local cfg = require("insis").config.telescope
local lga_actions = pRequire("telescope-live-grep-args.actions")

if telescope and lga_actions and cfg and cfg.enable then
  -- local actions = require("telescope.actions")
  telescope.setup({
    defaults = {
      initial_mode = "insert",
      -- vertical , center , cursor
      layout_strategy = "horizontal",
      mappings = {
        i = {
          -- move up and down
          [cfg.keys.move_selection_next] = "move_selection_next",
          [cfg.keys.move_selection_previous] = "move_selection_previous",
          -- history
          [cfg.keys.cycle_history_next] = "cycle_history_next",
          [cfg.keys.cycle_history_prev] = "cycle_history_prev",
          -- close window
          -- ["<esc>"] = actions.close,
          [cfg.keys.close] = "close",
          [cfg.keys.preview_scrolling_up] = "preview_scrolling_up",
          [cfg.keys.preview_scrolling_down] = "preview_scrolling_down",
        },
      },
    },
    pickers = {
      find_files = {
        -- theme = "dropdown", -- can be : dropdown, cursor, ivy
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          -- even more opts
          initial_mode = "normal",
        }),
      },
      live_grep_args = {
        auto_quoting = false, -- enable/disable auto-quoting
        -- mappings = { -- extend mappings
        --   i = {
        --     ["<C-k>"] = lga_actions.quote_prompt(),
        --   },
        -- },
      },
    },
  })

  keymap("n", cfg.keys.find_files, "<CMD>Telescope find_files<CR>")
  keymap("n", cfg.keys.live_grep, ":<CMD>Telescope live_grep<CR>")
  keymap("n", cfg.keys.live_grep_args, ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

  pcall(telescope.load_extension, "env")
  -- To get ui-select loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  pcall(telescope.load_extension, "ui-select")
  pcall(telescope.load_extension, "live_grep_args")
end
