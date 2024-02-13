vim.opt.mouse = "a" -- Enable mouse clicks everywhere
vim.opt.wildmode = "list,longest" -- Enable command tab completion
vim.opt.number = true -- Enable line numbers
vim.opt.tabstop = 4 -- Tab size 4 spaces
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true -- Indent newlines with tabs
vim.opt.ignorecase = true -- Search case insensitive
vim.opt.smartcase = true -- Except when using capitals
vim.opt.clipboard = "unnamedplus" -- Use system clipboard as default
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.path = ".,**" -- Allow searching nested directories for files
vim.opt.pumheight = 10 -- Max number of items to show in popup window
vim.opt.cmdheight = 0 -- Disable command area

vim.diagnostic.config({
    underline = false, -- Disable underlining for diagnostic messages
    virtual_text = {
        prefix = ''
    }
})

-- Configure diagnostic icons in the sidebar
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
