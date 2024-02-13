local colors = {
    pastel_pink = "#fca9f8",
    pastel_text = "#383838"
}

local function onColorSchemeChange()
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = colors.pastel_pink, fg = colors.pastel_text })
end

return {
    colors = colors,
    setup = function()
        vim.api.nvim_create_autocmd("ColorScheme", { callback = onColorSchemeChange })
    end,
}
