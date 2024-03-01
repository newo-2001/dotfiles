return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local icons = require("config.theme").icons

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
                            error = icons.error .. ' ',
                            warn = icons.warn .. ' ',
                            info = icons.info .. ' ',
                            hint = icons.hint .. ' '
                        }
                    },
                    "diff",
                    require("lualine_sections.spotify"),
                },
                lualine_c = {
                    "searchcount"
                },
                lualine_x = {},
                lualine_y = {
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
                    "datetime"
                }
            }
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
}
