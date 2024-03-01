return {
    "lervag/vimtex",
    config = function()
        if require("utils").isWSL() then
            vim.g.vimtex_view_general_viewer = vim.env.LOCALAPPDATA .. "/SumatraPDF/SumatraPDF.exe"
            vim.g.vimtex_view_general_options = "-reuse-instance"
        end

        -- Disable quickfix menu when there are warnings but no errors
        vim.g.vimtex_quickfix_open_on_warning = 0
    end
}
