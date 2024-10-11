local utils = require("utils")
local has_ghcup = vim.fn.executable("ghcup") ~= 0

local function on_attach(client, buff_nr)
    if client.server_capabilities.signatureHelpProvider then
        require("lsp-overloads").setup(client, {})
        vim.cmd("nnoremap <silent> <buffer> <Leader>ss :LspOverloadsSignature<CR>")
        vim.cmd("inoremap <silent> <buffer> <Leader>ss :LspOverloadsSignature<CR>")
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { buff_nr })
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
                "lua_ls",                          -- lua
                "omnisharp",                       -- C#
                "texlab",                          -- LaTeX
                "ts_ls",                           -- Typescript
                "jsonls",                          -- Json
                "yamlls",                          -- Yaml
                "terraformls",                     -- Terraform
                "clangd",                          -- C++
                "pyright",                         -- Python
                "rust_analyzer",                   -- Rust
                "html",                            -- HTML
                "powershell_es",                   -- PowerShell
                "dockerls",                        -- Dockerfile
                "docker_compose_language_service"  -- Docker compose
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
                "texlab",
                "ts_ls",
                "terraformls",
                "clangd",
                "pyright",
                "html",
                {
                    "lua_ls",
                    opts = {
                        settings = {
                            Lua = {
                                hint = { enable = true }
                            }
                        }
                    }
                },
                {
                    "powershell_es",
                    opts = function()
                        if utils.is_wsl() then
                            -- If we are under wsl we have to start PowerShell on the windows host
                            -- Additionally we need to point the bundle to the one downloaded by mason under WSL
                            return {
                                shell = "powershell.exe",
                                bundle_path = [[\\wsl$\]] .. utils.linux_distro() .. vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
                            }
                        else
                            return {
                                shell = "pwsh",
                                bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
                            }
                        end
                    end
                },
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
                        },
                        settings = {
                            ["rust-analyzer"] = {
                                inlayHints = {
                                    chainingHints = { enable = true },
                                    parameterHints = { enable = true },
                                    maxLength = 25,
                                    renderColons = true,
                                    typeHints = {
                                        enable = true,
                                        hideClosureInitialization = false,
                                        hideNamedConstructor = false
                                    }
                                }
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
                                schemas = schemastore.yaml.schemas({
                                    replace = {
                                        ["Azure Pipelines"] = {
                                            description = "Azure Pipelines YAML pipelines definition",
                                            fileMatch = { "azure-pipelines*.y*l"},
                                            name = "Azure Pipelines",
                                            url = "https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"
                                        }
                                    }
                                })
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
                    -- Resolve lazy option
                    if type(language_server.opts) == "function" then
                        language_server.opts = language_server.opts()
                    end

                    if type(language_server.opts) ~= "table" then
                        error("Language server options has to be table or a function that returns a table")
                    end

                    options = utils.merge_tables(language_server.opts, options)

                    -- In case of the opts being a table the first entry is the name of language server
                    language_server = language_server[1]
                end

                if type(language_server) == "string" then
                    lspconfig[language_server].setup(options or {})
                else
                    error("Language server has to resolve to a string value")
                end
            end
        end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp"
        }
    },
    {
        "cameron-wags/rainbow_csv.nvim",
        config = function()
            require("rainbow_csv").setup()

            local colors = require("../config/theme").colors

            -- Numbers because terminal colors do not accept hex values
            vim.g.rcsv_colorpairs = {
                { 1, colors.blue },
                { 2, colors.peach },
                { 3, colors.red },
                { 4, colors.green },
                { 5, colors.mauve },
                { 6, colors.yellow },
                { 7, colors.text }
            }
        end,
        ft = {
            "csv",
            "tsv",
            "csv_semicolon"
        },
        cmd = {
            "RainbowDelim",
            "RainbowDelimSimple",
            "RainbowDelimQuoted",
            "RainbowMultiDelim"
        }
    },
    "Issafalcon/lsp-overloads.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "ionide/Ionide-vim",
    "b0o/SchemaStore.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim",
}
