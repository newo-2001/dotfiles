local utils = require("utils")

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
                    "omnisharp",
                    "texlab",
                    "tsserver"
                }
            })
        end,
        dependencies = { "williamboman/mason.nvim" }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local language_servers = {
                "lua_ls",
                "texlab",
                "tsserver"
            }

            for _, language_server in pairs(language_servers) do
                lspconfig[language_server].setup({ capabilities = capabilities })
            end

            lspconfig.omnisharp.setup({
                capabilities = capabilities,
                enable_import_completion = true,
                enable_roslyn_analyzers = true,
                analyze_open_document_only = false,
                cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" }
            })
        end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp"
        }
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup()
        end
    },
    {
        "lervag/vimtex",
        config = function()
            if utils.isWSL() then
                vim.g.vimtex_view_general_viewer = vim.env.LOCALAPPDATA .. "/SumatraPDF/SumatraPDF.exe"
                vim.g.vimtex_view_general_options = "-reuse-instance"
            end

            -- Disable quickfix menu when there are warnings but no errors
            vim.g.vimtex_quickfix_open_on_warning = 0
        end
    },
    "hrsh7th/cmp-nvim-lsp",
    "ionide/Ionide-vim"
}
