local dap = pRequire("dap")
local dapui = pRequire("dapui")
local M = {}
if dap and dapui then
  local cfg = require("insis").config.dap

  M.keyAttach = function()
    -- run
    keymap("n", cfg.continue, dap.continue)
    -- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

    --  stepOver, stepInto, stepOut,
    keymap("n", cfg.step_over, dap.step_over)
    keymap("n", cfg.step_into, dap.step_into)
    keymap("n", cfg.step_out, dap.step_out)

    keymap("n", cfg.toggle_breakpoint, dap.toggle_breakpoint)
    -- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    -- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    keymap("n", cfg.clear_breakpoints, dap.clear_breakpoints)

    keymap("n", cfg.eval, dapui.eval)
    -- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>

    keymap("n", cfg.terminate, dap.terminate)
    -- keymap(
    --   "n",
    --   "<leader>de",
    --   ":lua require'dap'.close()<CR>"
    --     .. ":lua require'dap'.terminate()<CR>"
    --     .. ":lua require'dap.repl'.close()<CR>"
    --     .. ":lua require'dapui'.close()<CR>"
    --     .. ":lua require('dap').clear_breakpoints()<CR>"
    --     .. "<C-w>o<CR>"
    -- )

    -- rust
    -- map("n", "<leader>dd", ":RustDebuggables<CR>", opt)
  end
end

return M
