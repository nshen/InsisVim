local M = {}

-- com.apple.inputmethod.SCIM.ITABC
M.defaultIM = "com.apple.keylayout.ABC"
M.currentIM = M.defaultIM

local Job = require("plenary.job")
local isImSelectJobRunning = false

local function onJobStart()
  isImSelectJobRunning = true
end

local function onJobExit()
  isImSelectJobRunning = false
end

local executeImSelectJob = function(command, im)
  Job:new({
    command = command,
    args = { im },
    on_start = onJobStart,
    on_exit = onJobExit,
  }):start()
end

local macInsertEnter = function()
  executeImSelectJob("im-select", M.currentIM)
end

local macInsertLeave = function()
  M.currentIM = trim(vim.fn.system({ "im-select" }))
  if M.currentIM ~= M.defaultIM then
    executeImSelectJob("im-select", M.defaultIM)
  end
end

local windowsInsertLeave = function()
  -- TODO: Test on windows
  executeImSelectJob("~/.config/nvim/im-select.exe", "1033")
  -- vim.cmd(":silent :!~/.config/nvim/im-select.exe 1033")
end

local windowsInsertEnter = function()
  -- TODO: Test on windows
  executeImSelectJob("~/.config/nvim/im-select.exe", "2052")
  -- vim.cmd(":silent :!~/.config/nvim/im-select.exe 2052")
end

M.insertEnter = function()
  if isImSelectJobRunning then
    return
  end
  if vim.fn.executable("im-select") ~= 1 and vim.fn.executable("im-select.exe") ~= 1 then
    vim.notify("没有找到 im-select 无法切换输入法, https://github.com/daipeihust/im-select")
    return
  end

  if vim.fn.has("macunix") == 1 then
    macInsertEnter()
  elseif vim.fn.has("win32") then
    windowsInsertEnter()
  end
end

M.insertLeave = function()
  if isImSelectJobRunning then
    return
  end
  if vim.fn.executable("im-select") ~= 1 and vim.fn.executable("im-select.exe") ~= 1 then
    vim.notify("没有找到 im-select 无法切换输入法, https://github.com/daipeihust/im-select")
    return
  end
  if vim.fn.has("macunix") == 1 then
    macInsertLeave()
  elseif vim.fn.has("win32") then
    windowsInsertLeave()
  end
end

return M
