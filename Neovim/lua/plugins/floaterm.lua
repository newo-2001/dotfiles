return {
    "voldikss/vim-floaterm",
    config = function()
        vim.keymap.set({ 'n', 't' }, "<Leader>tt", function() vim.cmd("FloatermToggle") end)
        vim.keymap.set('t', "<Esc>", function() vim.cmd("FloatermHide") end)
        vim.g.floaterm_shell = "bash --login"
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
        vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
    end
}
