---@diagnostic disable: unused-local, unused-function
local gitsigns = pRequire("gitsigns")
local cfg = require("insis").config.git

if gitsigns and cfg and cfg.enable then
  local gitsigns_on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local mapkey = function(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    mapkey("n", "<leader>gj", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, {
      expr = true,
    })

    mapkey("n", "<leader>gk", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, {
      expr = true,
    })

    mapkey({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
    mapkey("n", "<leader>gS", gs.stage_buffer)
    mapkey("n", "<leader>gu", gs.undo_stage_hunk)
    mapkey({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
    mapkey("n", "<leader>gR", gs.reset_buffer)
    mapkey("n", "<leader>gp", gs.preview_hunk)
    mapkey("n", "<leader>gb", function()
      gs.blame_line({
        full = true,
      })
    end)
    mapkey("n", "<leader>gd", gs.diffthis)
    mapkey("n", "<leader>gD", function()
      gs.diffthis("~")
    end)
    -- toggle
    mapkey("n", "<leader>gtd", gs.toggle_deleted)
    mapkey("n", "<leader>gtb", gs.toggle_current_line_blame)
    -- Text object
    mapkey({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
  end

  gitsigns.setup({
    --  A for add
    --  C for change
    --  D for delete
    signs = {
      add = { text = "+|" },
      change = { text = "c|" },
      delete = { text = "d_" },
      topdelete = { text = "d‾" },
      changedelete = { text = "d~" },
      untracked = { text = "┆" },
    },
    -- sign display
    signcolumn = cfg.signcolumn, -- Toggle with `:Gitsigns toggle_signs`
    -- do not highlight line number
    numhl = cfg.numhl, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = cfg.linehl, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = cfg.word_diff, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = cfg.current_line_blame, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    -- I'm not gona remember these keys for now, let's use code action
    -- on_attach = gitsigns_on_attach,
  })
end
