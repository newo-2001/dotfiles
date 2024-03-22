return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true
            },
            ensure_installed = {
                "arduino",
                "bash",
                "bibtex",
                "bicep",
                "c",
                "c_sharp",
                "cpp",
                "css",
                "csv",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "haskell",
                "html",
                "ini",
                "java",
                "javascript",
                "json",
                "latex",
                "lua",
                "markdown",
                "php",
                "printf",
                "python",
                "regex",
                "rust",
                "scss",
                "sql",
                "ssh_config",
                "terraform",
                "tmux",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "xml",
                "yaml",
            }
        })
    end
}
