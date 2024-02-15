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
                }
            })

            telescope.load_extension("ui-select")

            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        end
    },
    "nvim-telescope/telescope-ui-select.nvim"
}
