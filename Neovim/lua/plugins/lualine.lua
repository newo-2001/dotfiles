return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local theme = require("config.theme")

        require("lualine").setup({
            options = {
                theme = "catppuccin",
                globalstatus = true
            },
            sections = {
                lualine_a = {
                    "mode"
                },
                lualine_b = {
                    "branch",
                    {
                        "diagnostics",
                        symbols = {
                            error = theme.icons.error .. ' ',
                            warn = theme.icons.warn .. ' ',
                            info = theme.icons.info .. ' ',
                            hint = theme.icons.hint .. ' '
                        }
                    },
                    {
                        "diff",
                        diff_color = {
                            added = { fg = theme.colors.green },
                            modified = { fg = theme.colors.peach },
                            removed = { fg = theme.colors.red }
                        }
                    },
                    require("lualine_sections.spotify"),
                },
                lualine_c = {
                    "searchcount"
                },
                lualine_x = { },
                lualine_y = {
                    function()
                        if vim.bo.filetype == "http" then
                            local env = require("kulala").get_selected_env()
                            return "󰫧 " .. env
                        end

                        return ""
                    end,
                    "encoding",
                    {
                        "fileformat",
                        symbols = {
                            unix = "LF",
                            mac = "LF",
                            dos = "CRLF"
                        }
                    }
                },
                lualine_z = {
                    require("lualine_sections.datetime")
                }
            }
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
}
