return {
    "voldikss/vim-floaterm",
    config = function()
        vim.keymap.set({ 'n', 't' }, "<Leader>tt", "<C-\\><C-n>:FloatermToggle<CR>")
        vim.g.floaterm_shell = "bash --login"
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
    end
}
