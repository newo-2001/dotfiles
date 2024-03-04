local hl = {
    file_name = "WinBarFileName",
    file_path = "WinBarFilePath",
    separator = "WinBarSeparator"
}

local web_devicons = require("nvim-web-devicons")
local colors = require("config.theme").colors

-- https://github.com/fgheng/winbar.nvim/blob/main/lua/winbar/winbar.lua
local function get_title()
    local file_name = vim.fn.expand("%:t")
    local file_type = vim.fn.expand("%:e")
    local file_path = vim.fn.expand("%:~:.:h")

    local file_icon = web_devicons.get_icon(file_name, file_type, { default = '' } )
    local hl_file_icon = "DevIcon" .. file_type

    local title_file_icon = "%#" .. hl_file_icon .. '#' .. file_icon .. "%*"
    local title_file_name = "%#" .. hl.file_name .. '#' .. file_name .. "%*"

    local title_path = ""
    for dir in file_path:gmatch("[^/]+") do
        title_path = title_path .. "%#" .. hl.file_path .. '#' .. dir .. "%#" .. hl.separator .. "# > "
    end

    return title_path .. title_file_icon .. ' ' .. title_file_name
end

local excluded_file_types = {
    "",
    "help",
    "floaterm",
    "neo-tree"
}

local function should_show()
    if vim.bo.filetype == nil then return false end

    for _, file_type in pairs(excluded_file_types) do
        if vim.bo.filetype == file_type then return false end
    end

    return true
end

local function update_winbar()
    if not should_show() then
        vim.opt_local.winbar = nil
        return
    end

    vim.opt_local.winbar = get_title()
end

vim.api.nvim_create_autocmd(
    { "DirChanged", "BufWinEnter", "BufFilePost", "BufWritePost" },
    { callback = update_winbar }
)

vim.api.nvim_set_hl(0, hl.file_name, { fg = colors.mauve })
vim.api.nvim_set_hl(0, hl.file_path, { fg = colors.blue })
vim.api.nvim_set_hl(0, hl.separator, { fg = colors.text })

return {
    hl = hl
}
