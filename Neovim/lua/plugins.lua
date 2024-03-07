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
    "romainl/vim-qf"
}
