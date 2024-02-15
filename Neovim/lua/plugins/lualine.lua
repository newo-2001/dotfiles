return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local theme = require("config.theme")
        local white = "#eeeeee"
        local gray = "#2f2f2f"
        local lightgray = "#434343"

        local custom_theme = require("lualine.themes.modus-vivendi")
        custom_theme.terminal = {
            a = {
                bg = theme.colors.pink,
                fg = theme.colors.text_dark,
                gui = "bold"
            },
            b = {
                bg = lightgray,
                fg = theme.colors.pink
            },
            c = {
                bg = gray,
                fg = white
            }
        }

        require("lualine").setup({
            options = {
                theme = custom_theme,
                globalstatus = true
            },
            sections = {
                lualine_a = {
                    "mode"
                },
                lualine_b = {
                    "branch",
                    require("lualine_sections.spotify"),
                    "diff",
                    {
                        "diagnostics",
                        symbols = {
                            error = theme.icons.error,
                            warn = theme.icons.warn,
                            info = theme.icons.info,
                            hint = theme.icons.hint
                        }
                    }
                },
                lualine_c = {
                    "searchcount"
                },
                lualine_x = {
                    "encoding",
                    {
                        "fileformat",
                        symbols = {
                            unix = "LF",
                            mac = "LF",
                            dos = "CRLF"
                        }
                    },
                    "filetype"
                },
                lualine_y = {
                    "location",
                    "progress"
                },
                lualine_z = {
                    "datetime"
                }
            }
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
}
