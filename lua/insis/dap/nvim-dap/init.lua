local dap = pRequire("dap")
local dapui = pRequire("dapui")
local vt = pRequire("nvim-dap-virtual-text")

if dap and dapui and vt then
  local cfg = require("insis").config
  require("insis.dap.nvim-dap.ui")

  vt.setup({
    commented = true,
  })

  dapui.setup({
    element_mappings = {
      scopes = {
        open = "<CR>",
        edit = "e",
        expand = "o",
        repl = "r",
      },
    },
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          { id = "scopes", size = 0.4 },
          "stacks",
          "watches",
          "breakpoints",
          "console",
        },
        size = 0.35, -- 40 columns
        position = "left",
      },
      {
        elements = {
          "repl",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "rounded", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
  })

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  if cfg.lua and cfg.lua.enable then
    require("insis.dap.nvim-dap.config.lua").setup()
  end

  if cfg.golang and cfg.golang.enable then
    require("dap-go").setup()
  end

  -- if cfg.cpp and cfg.cpp.enable then
  --   require("insis.dap.nvim-dap.config.cpp").setup()
  -- end

  if cfg.frontend and cfg.frontend.enable then
    require("insis.dap.nvim-dap.config.vscode-js")
  end

  require("insis.dap.nvim-dap.common-config").keyAttach()
end
