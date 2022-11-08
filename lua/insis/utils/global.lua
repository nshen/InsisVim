-- Global functions

function _G.pRequire(name)
  local status_ok, plugin = pcall(require, name)
  if not status_ok then
    vim.notify(" Can't find: " .. name)
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
