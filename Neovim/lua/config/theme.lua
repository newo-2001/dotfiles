local colors = {
    neovim_blue = "#3E93D3",
    neovim_green = "#69A33E",
    snowy = "#f2f4ff"
}

for name, color in pairs(require("catppuccin.palettes").get_palette("mocha")) do
    colors[name] = color
end

local icons = {
    error = "",
    warn = "",
    hint = "󰌵",
    info = ""
}

local function onColorSchemeChange()
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.peach })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red })

    vim.api.nvim_set_hl(0, "Floaterm", { bg = colors.crust })
    vim.api.nvim_set_hl(0, "FloatermBorder", { bg = colors.crust })

    vim.api.nvim_set_hl(0, "CursorLineNR", { fg = colors.pink })

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

        vim.diagnostic.config({
            underline = false, -- Disable underlining for diagnostic messages
            virtual_text = {
                prefix = ''
            }
        })

        -- Configure diagnostic icons in the sidebar
        local signs = { Error = icons.error, Warn = icons.warn, Hint = icons.hint, Info = icons.info }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end,
}
