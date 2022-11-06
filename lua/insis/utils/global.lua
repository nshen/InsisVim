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
  if not (type(lhs) == "string") then
    return
  end
  if not (type(rhs) == "string") then
    return
  end
  opts = opts or {}
  local default_opts = {
    remap = false,
    silent = true,
  }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
end
