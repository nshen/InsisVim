-- TODO: not work
local dap = require("dap")
print("tppython..", dap)
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return "/Users/nn/.asdf/shims/python"
    end,
  },
}
