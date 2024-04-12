local utils = require("utils")
local has_ghcup = vim.fn.executable("ghcup") ~= 0

local function on_attach(client)
    if client.server_capabilities.signatureHelpProvider then
        require("lsp-overloads").setup(client, {})
        vim.cmd("nnoremap <silent> <buffer> <Leader>ss :LspOverloadsSignature<CR>")
        vim.cmd("inoremap <silent> <buffer> <Leader>ss :LspOverloadsSignature<CR>")
    end
end

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
                "clangd",       -- C++
                "pyright",      -- Python
                "rust_analyzer" -- Rust
            }

            -- Only install haskell ls if the compiler is also installed
            if has_ghcup then table.insert(language_servers, "hls") end

            require("mason-lspconfig").setup({ ensure_installed = language_servers })
        end,
        dependencies = { "williamboman/mason.nvim" }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local schemastore = require("schemastore")
            local omnisharp_extended = require("omnisharp_extended")

            local language_servers = {
                "lua_ls",
                "texlab",
                "tsserver",
                "terraformls",
                "clangd",
                "pyright",
                {
                    "rust_analyzer",
                    opts = {
                        checkOnSave = {
                            command = "clippy",
                            extraArgs = {
                                "--",
                                "--no-deps",
                                "-Wclippy::pedantic"
                            }
                        }
                    }
                },
                {
                    "omnisharp",
                    opts = {
                        enable_import_completion = true,
                        enable_roslyn_analyzers = true,
                        enable_editor_config_support = true,
                        analyze_open_document_only = false,
                        cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
                        handlers = {
                            ["textDocument/definition"] = omnisharp_extended.definition_handler,
                            ["textDocument/typeDefinition"] = omnisharp_extended.type_definition_handler,
                            ["textDocument/references"] = omnisharp_extended.references_handler,
                            ["textDocument/implementation"] = omnisharp_extended.implementation_handler
                        }
                    }
                },
                {
                    "jsonls",
                    opts = {
                        settings = {
                            json = {
                                validate = { enable = true },
                                schemas = schemastore.json.schemas({
                                    extra = {}
                                })
                            }
                        }
                    }
                },
                {
                    "yamlls",
                    opts = {
                        settings = {
                            yaml = {
                                schemaStore = {
                                    enable = false,
                                    url = "",
                                },
                                schemas = schemastore.yaml.schemas()
                            }
                        }
                    }
                }
            }

            if has_ghcup then table.insert(language_servers, "hls") end

            for _, language_server in pairs(language_servers) do
                local options = {
                    capabilities = capabilities,
                    on_attach = on_attach
                }

                if type(language_server) == "table" then
                    options = utils.merge_tables(language_server.opts, options)
                    language_server = language_server[1]
                end

                lspconfig[language_server].setup(options)
            end
        end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp"
        }
    },
    "Issafalcon/lsp-overloads.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "ionide/Ionide-vim",
    "b0o/SchemaStore.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim"
}
