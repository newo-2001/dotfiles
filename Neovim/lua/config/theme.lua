local colors = {
    pink = "#fca9f8",
    green = "#73a942",
    red = "#fd7272",
    orange = "#ff9105",
    text_dark = "#383838"
}

local icons = {
    error = "",
    warn = "",
    hint = "󰌵",
    info = ""
}

local function onColorSchemeChange()
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = colors.pink, fg = colors.text_dark })

    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.orange })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red })

    vim.api.nvim_set_hl(0, "Floaterm", { bg = "#212529" })
    vim.api.nvim_set_hl(0, "FloatermBorder", { bg = "#212529" })

    vim.api.nvim_set_hl(0, "CursorLineNR", { fg = colors.pink })

    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#69A33E" })

    local transparent = {}
    for _, group in pairs(transparent) do
        vim.api.nvim_set_hl(0, group, { guibg = nil, ctermbg = nil })
    end
end

return {
    colors = colors,
    icons = icons,
    setup = function()
        vim.api.nvim_create_autocmd("ColorScheme", { callback = onColorSchemeChange })
    end,
}
