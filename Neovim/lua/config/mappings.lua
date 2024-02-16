-- Enable 'hard' mode
local function noop() end
vim.keymap.set('n', "<Up>", noop)
vim.keymap.set('n', "<Down>", noop)
vim.keymap.set('n', "<Left>", noop)
vim.keymap.set('n', "<Right>", noop)


vim.keymap.set({ 'n', 'v' }, "<Leader>ca", vim.lsp.buf.code_action) -- Code Action
vim.keymap.set('n', "<C-K>", vim.lsp.buf.signature_help)
vim.keymap.set('n', "<Leader>dd", vim.diagnostic.open_float) -- Diagnostic Display
vim.keymap.set('n', "<Leader>dn", vim.diagnostic.goto_next) -- Diagnostic Next
vim.keymap.set('n', "<Leader>dp", vim.diagnostic.goto_prev) -- Diagnostic Previous
