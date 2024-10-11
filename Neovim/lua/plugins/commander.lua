local function noop() end

return {
    "FeiyouG/commander.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "lewis6991/gitsigns.nvim"
    },
    config = function()
        local commander = require("commander")
        local telescope = require("telescope.builtin")
        local gitsigns = require("gitsigns")

        commander.setup({
            integration = {
                telescope = {
                    enable = true,
                    theme = require("telescope.themes").commander
                }
            },
            components = {
                "DESC",
                "KEYS",
                "CAT"
            },
            sort_by = {
                "CAT",
                "DESC"
            }
        })

        commander.add({
            {
                desc = "Find commands and keybinds",
                keys = { 'n', "<Leader>fc" },
                cmd = commander.show,
                cat = "Find"
            },
            {
                desc = "Find files",
                keys = { 'n', "<Leader>ff" },
                cmd = telescope.find_files,
                cat = "Find"
            },
            {
                desc = "Find hidden files",
                keys = { 'n', "<Leader>fh" },
                cmd = function() telescope.find_files({ no_ignore = true }) end,
                cat = "Find"
            },
            {
                desc = "Find recent files",
                keys = { 'n', "<Leader>fr" },
                cmd = telescope.oldfiles,
                cat = "Find"
            },
            {
                desc = "Find text in files",
                keys = { 'n', "<Leader>fg" },
                cmd = telescope.live_grep,
                cat = "Find"
            },
            {
                desc = "Change directory with zoxide",
                keys = { 'n', "<Leader>cd" },
                cmd = require("telescope").extensions.zoxide.list,
                cat = "Find"
            },
            {
                desc = "Find icon",
                keys = { 'n',  "<Leader>fi" },
                cmd = "<CMD>IconPickerInsert<CR>",
                cat = "Find"
            },
            {
                desc = "Open code actions menu",
                keys = {{ 'v', 'n' }, "<Leader>ca" },
                cmd = require("actions-preview").code_actions,
                cat = "Lsp"
            },
            {
                desc = "Show function signature",
                keys = { 'n', "<Leader>ss" },
                cmd = vim.lsp.buf.signature_help,
                cat = "Lsp"
            },
            {
                desc = "Display diagnostic",
                keys = { 'n', "<Leader>dd" },
                cmd = vim.diagnostic.open_float,
                cat = "Lsp"
            },
            {
                desc = "Next diagnostic",
                keys = { 'n', "<Leader>dn" },
                cmd = vim.diagnostic.goto_next,
                cat = "Lsp"
            },
            {
                desc = "Previous diagnostic",
                keys = { 'n', "<Leader>dp" },
                cmd = vim.diagnostic.goto_prev,
                cat = "Lsp"
            },
            {
                desc = "Preview hunk",
                keys = { 'n', "<Leader>hp" },
                cmd = gitsigns.preview_hunk,
                cat = "Git"
            },
            {
                desc = "Stage hunk",
                keys = { 'n', "<Leader>hs" },
                cmd = gitsigns.stage_hunk,
                cat = "Git"
            },
            {
                desc = "Reset hunk",
                keys = { 'n', "<Leader>hr" },
                cmd = gitsigns.reset_hunk,
                cat = "Git"
            },
            {
                desc = "Next hunk",
                keys = { 'n', "<Leader>hj" },
                cmd = gitsigns.next_hunk,
                cat = "Git"
            },
            {
                desc = "Previous hunk",
                keys = { 'n', "<Leader>hk" },
                cmd = gitsigns.prev_hunk,
                cat = "Git"
            },
            {
                desc = "Toggle terminal",
                keys = { { 'n', 't' }, "<Leader>tt" },
                cmd = "<CMD>FloatermToggle<CR>",
                cat = "Term"
            },
            {
                desc = "Hide terminal",
                keys = { 't', "<Esc>" },
                cmd = "<CMD>FloatermHide<CR>",
                cat = "Term",
                show = false
            },
            {
                desc = "Toggle filetree",
                keys = { 'n', "<Leader>tf" },
                cmd = "<CMD>Neotree toggle<CR>",
            },
            {
                desc = "Toggle LaTeX live preview",
                keys = { 'n', "<Leader>ll" },
                cmd = "<CMD>VimtexCompile<CR>",
                cat = "LaTeX",
                set = false
            },
            {
                desc = "Show LaTeX debug info",
                keys = { 'n', "<Leader>li" },
                cmd = "<CMD>VimtexInfo<CR>",
                cat = "LaTeX",
                set = false
            },
            {
                desc = "Show LaTeX log",
                keys = { 'n', "<Leader>lq" },
                cmd = "<CMD>VimtexLog<CR>",
                cat = "LaTeX",
                set = false
            },
            {
                desc = "Clean LaTeX output directory",
                keys = { 'n', "<Leader>lc" },
                cmd = "<CMD>VimtexClean<CR>",
                cat = "LaTeX",
                set = false
            },
            {
                desc = "Suggest spelling correction",
                keys = { 'n', "<Leader>z=" },
                cmd = telescope.spell_suggest,
                cat = "Spell"
            },
            {
                desc = "Add word to spelling dictionary",
                keys = { 'n', "<Leader>zg" },
                cat = "Spell",
                cmd = "<CMD>spellgood<CR>",
                set = false
            },
            {
                desc = "Create vertical split",
                keys = { 'n', "<C-w>v" },
                cmd = "<CMD>vsplit<CR>",
                cat = "Win",
                set = false
            },
            {
                desc = "Create horizontal split",
                keys = { 'n', "<C-w>s" },
                cmd = "<CMD>split<CR>",
                cat = "Win",
                set = false
            },
            {
                desc = "Goto definition",
                keys = { 'n', "<Leader>gd" },
                cmd = vim.lsp.buf.definition,
                cat = "Lsp"
            },
            {
                desc = "Goto declaration",
                keys = { 'n', "<Leader>gD" },
                cmd = vim.lsp.buf.declaration,
                cat = "Lsp"
            },
            {
                desc = "Goto implementation",
                keys = { 'n', "<Leader>gi" },
                cmd = vim.lsp.buf.implementation,
                cat = "Lsp"
            },
            {
                desc = "Find usages",
                keys = { 'n', "<Leader>fu" },
                cmd = telescope.lsp_references,
                cat = "Lsp"
            },
            {
                desc = "Run HTTP request",
                keys = { 'n', "<Leader>hr" },
                cmd = function() require("kulala").run() end
            },
            {
                desc = "Set HTTP environment",
                keys = { 'n', "<Leader>he" },
                cmd = function() require("kulala").set_selected_env() end
            },
            {
                desc = "Move to relative window",
                keys = { 'n', "<C-w>[hjkl<Arrow>]" },
                cmd = noop,
                cat = "Win",
                set = false
            },
            {
                desc = "Cycle through windows",
                keys = { 'n', "<C-w>w" },
                cmd = noop,
                cat = "Win",
                set = false
            },
            {
                desc = "Rotate window locations",
                keys = { 'n', "<C-w>x" },
                cat = "Win",
                cmd = noop,
                set = false
            },
            {
                desc = "Open autocomplete menu",
                keys = { 'i', "<C-Space>" },
                cmd = noop,
                cat = "Lsp",
                set = false
            }
        })
    end
}
