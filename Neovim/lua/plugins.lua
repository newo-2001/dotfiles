return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.g.mkdp_theme = "dark"
        end
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function() require("nvim-highlight-colors").setup() end
    },
    "aznhe21/actions-preview.nvim",
    "romainl/vim-cool",
    "romainl/vim-qf",
    "github/copilot.vim",
    {
        "mistweaverco/kulala.nvim",
        opts = {
            default_env = "Development",
            environment_scope = "g"
        }
    }
}
