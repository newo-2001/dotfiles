return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                autotag = { enable = true },
                highlight = {
                    enable = true,
                    disable = {
                        "csv" -- Prefer rainbow_csv highlighting
                    }
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
                    "yaml"
                }
            })
        end
    },
    "windwp/nvim-ts-autotag"
}
