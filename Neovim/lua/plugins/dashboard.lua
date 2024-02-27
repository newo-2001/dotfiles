return {
    "nvimdev/dashboard-nvim",
    config = function()
        require("dashboard").setup({
            theme = "hyper",
            config = {
                header = {                    
                    "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                    "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                    "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                    "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                    "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                    "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
                },
                footer = {},
                shortcut = {
                    {
                        icon = "",
                        desc = " Find File ",
                        action = "Telescope find_files",
                        key = "f"
                    }
                }
            }
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
}
