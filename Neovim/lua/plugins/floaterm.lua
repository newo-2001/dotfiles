return {
    "voldikss/vim-floaterm",
    config = function()
        vim.keymap.set('n', "<C-L>", ":FloatermToggle<CR>")
        vim.keymap.set('t', "<C-L>", "<C-\\><C-n>:FloatermToggle<CR>")
        vim.api.nvim_set_hl(0, "Floaterm", { bg = "#212529" })
        vim.api.nvim_set_hl(0, "FloatermBorder", { bg = "#212529" })
        vim.g.floaterm_shell = "bash --login"
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
    end
}
