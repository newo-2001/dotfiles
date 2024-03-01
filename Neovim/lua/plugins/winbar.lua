return {
    "fgheng/winbar.nvim",
    config = function()
        local colors = require("config.theme").colors
        require("winbar").setup({
            enabled = true,
            show_file_path = true,
            show_symbols = true,
            colors = {
                path = colors.snowy
            },
            exclude_filetype = {
                "help",
                "alpha",
                "qf",
                "floaterm",
                "neo-tree"
            }
        })
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    }
}