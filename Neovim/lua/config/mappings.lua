-- Enable 'hard' mode 
local function noop() end
vim.keymap.set('n', "<Up>", noop)
vim.keymap.set('n', "<Down>", noop)
vim.keymap.set('n', "<Left>", noop)
vim.keymap.set('n', "<Right>", noop)

-- Disable annoying 'ctrl+j = j' alias
vim.keymap.set('n', "<C-j>", noop)
