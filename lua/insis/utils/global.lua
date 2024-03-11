-- Global functions

function _G.pRequire(name)
  local status_ok, plugin = pcall(require, name)
  if not status_ok then
    -- vim.notify(" Can't find: " .. name)
    return nil
  end
  return plugin
end

function _G.getUserConfig(name)
  return require("insis").config[name]
end

function _G.logLspCap()
  print(vim.inspect(vim.lsp.get_active_clients()[1].resolved_capabilities))
end

function _G.log(v)
  print(vim.inspect(v))
  return v
end

function _G.keymap(mode, lhs, rhs, opts)
  if not lhs or not rhs then
    return
  end

  local keyOpts = vim.tbl_extend("force", { remap = false, silent = true }, (opts or {}))

  if type(lhs) == "table" then
    for _, x in pairs(lhs) do
      vim.keymap.set(mode, x, rhs, keyOpts)
    end
    return
  end

  vim.keymap.set(mode, lhs, rhs, keyOpts)
end

function _G.arrayConcat(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end
end

function _G.isWSL()
  local output = vim.fn.systemlist("uname -r")
  return not not string.find(output[1] or "", "WSL")
end

function _G.isMAC()
  return vim.fn.has("maxunic") == 1
end

function _G.isLinux(self)
  return not self.is_wsl() and not self.is_mac()
end

table.indexOf = function(t, object)
  if "table" == type(t) then
    for i = 1, #t do
      if object == t[i] then
        return i
      end
    end
    return -1
  else
    error("table.indexOf expects table for first argument, " .. type(t) .. " given")
  end
end

function _G.trim(s)
  return s:match("^%s*(.-)%s*$")
end
