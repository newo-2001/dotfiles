return {
    "catppuccin/nvim",
    name = "catpuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                cmp = true,
                gitsigns = true,
                mason = true,
                neotree = true,
                telescope = true
            },
            native_lsp = {
                enabled = true
            }
        })

        require("config.theme").setup()

        vim.cmd.colorscheme("catppuccin")
    end
}
