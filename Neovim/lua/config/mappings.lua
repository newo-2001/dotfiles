-- Enable 'hard' mode
local function noop() end
vim.keymap.set('n', "<Up>", noop)
vim.keymap.set('n', "<Down>", noop)
vim.keymap.set('n', "<Left>", noop)
vim.keymap.set('n', "<Right>", noop)

-- Open code actions
vim.keymap.set('n', "<Leader>ca", vim.lsp.buf.code_action)
