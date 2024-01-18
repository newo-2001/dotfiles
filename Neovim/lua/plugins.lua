return {
    {
        "williamboman/mason.nvim",
        config = function() require("mason").setup() end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "texlab"
                }
            })
        end,
        dependencies = { "williamboman/mason.nvim" }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local language_servers = {
                "lua_ls",
                "texlab"
            }

            for _, language_server in pairs(language_servers) do
                lspconfig[language_server].setup({})
            end
        end,
        dependencies = { "williamboman/mason-lspconfig.nvim" }
    },
    {
        "rebelot/kanagawa.nvim",
        config = function() require("kanagawa").load("wave") end
    },
    {
        "voldikss/vim-floaterm",
        config = function()
            vim.keymap.set('n', "<C-L>", ":FloatermToggle<CR>")
            vim.keymap.set('t', "<C-L>", "<C-\\><C-n>:FloatermToggle<CR>")
            vim.api.nvim_set_hl(0, "Floaterm", { bg = "#212529" })
            vim.api.nvim_set_hl(0, "FloatermBorder", { bg = "#212529" })
            vim.g.floaterm_shell = "bash --login"
            vim.g.floaterm_width = 0.8
            vim.g.floaterm_height = 0.8
        end
    }
}
