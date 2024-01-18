return {
    {
        "williamboman/mason.nvim",
        config = function() require("mason").setup() end,
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
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false })
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" }
                })
            })
        end,
        dependencies = { "L3MON4D3/LuaSnip" }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                popup_border_style = "rounded",
                filesystem = {
                    follow_current_file = { enabled = true }
                },
                event_handlers = {
                    {
                        event = "file_opened",
                        handler = function(file_path)
                            require("neo-tree.command").execute({ action = "close" })
                        end
                    }
                }
            })

            vim.keymap.set('n', "<C-T>", ":Neotree toggle<CR>")
        end
    }
}
