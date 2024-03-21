local has_ghcup = vim.fn.executable("ghcup") ~= 0

return {
    {
        "williamboman/mason.nvim",
        config = function() require("mason").setup() end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local language_servers = {
                "lua_ls",       -- lua
                "omnisharp",    -- C#
                "texlab",       -- LaTeX
                "tsserver",     -- Typescript
                "jsonls",       -- Json
                "yamlls",       -- Yaml
                "terraformls",  -- Terraform
            }
            
            -- Only install haskell ls if the compiler is also installed
            if has_ghcup then table.insert(language_servers, "hls") end

            require("mason-lspconfig").setup({
                ensure_installed = language_servers
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
                "tsserver",
                "terraformls"
            }

            if has_ghcup then table.insert(language_servers, "hls") end

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

            local schemastore = require("schemastore")
            lspconfig.jsonls.setup({
                capabilities = capabilities,
                settings = {
                    json = {
                        validate = { enable = true },
                        schemas = schemastore.json.schemas({
                            extra = {}
                        })
                    }
                }
            })

            lspconfig.yamlls.setup({
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = schemastore.yaml.schemas()
                    }
                }
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
    "hrsh7th/cmp-nvim-lsp",
    "ionide/Ionide-vim",
    "b0o/SchemaStore.nvim"
}
