local utils = require("utils")
local has_ghcup = vim.fn.executable("ghcup") ~= 0

local function on_attach(client, buff_nr)
    if client.server_capabilities.signatureHelpProvider then
        require("lsp-overloads").setup(client, {})
        vim.cmd("nnoremap <silent> <buffer> <Leader>ss :LspOverloadsSignature<CR>")
        vim.cmd("inoremap <silent> <buffer> <Leader>ss :LspOverloadsSignature<CR>")
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(buff_nr, true)
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
                "lua_ls",        -- lua
                "omnisharp",     -- C#
                "texlab",        -- LaTeX
                "tsserver",      -- Typescript
                "jsonls",        -- Json
                "yamlls",        -- Yaml
                "terraformls",   -- Terraform
                "clangd",        -- C++
                "pyright",       -- Python
                "rust_analyzer", -- Rust
                "html",          -- HTML
                "powershell_es"  -- PowerShell
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
                "html",
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
                        end

                        -- We disable PowerShell on windows for now, until I can test this on a Windows host
                        return nil
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
    "Issafalcon/lsp-overloads.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "ionide/Ionide-vim",
    "b0o/SchemaStore.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim"
}
