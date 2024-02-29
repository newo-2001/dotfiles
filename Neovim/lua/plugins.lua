return {
    {
        "olimorris/onedarkpro.nvim", config = function()
            vim.cmd("colorscheme onedark")
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.g.mkdp_theme = "dark"
        end
    },
    "romainl/vim-qf"
}
