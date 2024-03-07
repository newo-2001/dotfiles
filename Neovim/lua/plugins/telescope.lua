return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_cursor()
                    }
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "rg",
                            "--files",
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--smart-case",
                            "--hidden",
                            "--glob",
                            "!**/.git/*"
                        }
                    }
                },
                defaults = {
                    file_ignore_patterns = {
                        "%.jpe?g$",
                        "%.png$"
                    }
                }
            })

            telescope.load_extension("ui-select")
            telescope.load_extension("zoxide")

            vim.keymap.set('n', "<Leader>ff", builtin.find_files, {})
            vim.keymap.set('n', "<Leader>fg", builtin.live_grep, {})
            vim.keymap.set('n', "<Leader>fr", builtin.oldfiles, {})
            vim.keymap.set('n', "<Leader>fh", function() builtin.find_files({ no_ignore = true }) end, {})
            vim.keymap.set('n', "<Leader>cd", telescope.extensions.zoxide.list, {})
        end
    },
    {
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true
            })

            vim.keymap.set('n', "<Leader>fi", function() vim.cmd("IconPickerInsert") end, {})
        end
    },
    "nvim-telescope/telescope-ui-select.nvim",
    "jvgrootveld/telescope-zoxide"
}
