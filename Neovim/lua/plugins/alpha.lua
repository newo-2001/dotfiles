return {
    "goolord/alpha-nvim",
    config = function()
        require("alpha").setup(require("alpha_themes.yuki"))
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim"
    }
}
