-- /Users/nn/.local/share/nvim/site/pack/packer/start/vimspector
-- vimspector
-- start
keymap("n", "<leader>dd", ":call vimspector#Launch()<CR>")
-- end
keymap("n", "<Leader>de", ":call vimspector#Reset()<CR>")
-- continue
keymap("n", "<Leader>dc", ":call vimspector#Continue()<CR>")
-- breakpoints
keymap("n", "<Leader>dt", ":call vimspector#ToggleBreakpoint()<CR>")
keymap("n", "<Leader>dT", ":call vimspector#ClearBreakpoints()<CR>")
--  stepOver, stepOut, stepInto
keymap("n", "<leader>dj", "<Plug>VimspectorStepOver")
keymap("n", "<leader>dk", "<Plug>VimspectorStepOut")
keymap("n", "<leader>dl", "<Plug>VimspectorStepInto")
