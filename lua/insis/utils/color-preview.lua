-- based on https://www.youtube.com/playlist?list=PLOe6AggsTaVsMfLjXeavVwzkmOfAZnfQb
local telescope = pRequire("telescope")
if not telescope then
  return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local mycolors = {
  "nord",
  "onedark",
  "gruvbox",
  "tokyonight",
  "nightfox",
  "nordfox",
  "duskfox",
  "dracula",
  "kanagawa",
}

local mini = {
  layout_strategy = "vertical",
  layout_config = {
    width = 0.2,
    height = 12,
    prompt_position = "top",
  },
  sorting_strategy = "ascending",
}

local function enter(prompt_buffer)
  -- local selected = action_state.get_selected_entry()
  -- local cmd = "colorscheme " .. selected[1]
  -- vim.cmd(cmd)
  actions.close(prompt_buffer)
end

local function next_color(prompt_buffer)
  actions.move_selection_next(prompt_buffer)
  local selected = action_state.get_selected_entry()
  require("insis").config.colorscheme = selected[1]
  package.loaded["insis.plugins.lualine"] = nil
  require("insis.plugins.lualine")
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

local function prev_color(prompt_buffer)
  actions.move_selection_previous(prompt_buffer)
  local selected = action_state.get_selected_entry()
  require("insis").config.colorscheme = selected[1]
  package.loaded["insis.plugins.lualine"] = nil
  require("insis.plugins.lualine")
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

local opts = {
  prompt_title = "colorscheme",
  initial_mode = "normal",
  finder = finders.new_table(mycolors),
  sorter = sorters.get_generic_fuzzy_sorter({}),
  attach_mappings = function(_, map)
    map("i", "<CR>", enter)
    map("i", "<C-k>", prev_color)
    map("i", "<C-j>", next_color)
    map("n", "<CR>", enter)
    map("n", "k", prev_color)
    map("n", "j", next_color)
    return true
  end,
}

local colorPicker = pickers.new(mini, opts)

local function colorPreview()
  colorPicker:find()
end

vim.api.nvim_create_user_command("InsisColorPreview", colorPreview, {})
