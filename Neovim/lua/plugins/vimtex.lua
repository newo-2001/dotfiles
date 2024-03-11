return {
    "lervag/vimtex",
    config = function()
        local utils = require("utils")
        if utils.isWSL() then
            vim.g.vimtex_view_general_viewer = vim.env.LOCALAPPDATA .. "/SumatraPDF/SumatraPDF.exe"
            vim.g.vimtex_view_general_options = "-reuse-instance"
        elseif utils.isWindows() then
            vim.g.vimtex_view_general_viewer = vim.env.LOCALAPPDATA .. "/SumatraPDF/SumatraPDF.exe"
            vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
        end

        -- Disable quickfix menu when there are warnings but no errors
        vim.g.vimtex_quickfix_open_on_warning = 0
    end
}
