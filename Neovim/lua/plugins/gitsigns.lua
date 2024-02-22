return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns");
        gitsigns.setup({
            preview_config = {
                border = "rounded"
            }
        });
        
        vim.keymap.set('n', "<Leader>hp", gitsigns.preview_hunk)
        vim.keymap.set('n', "<Leader>hs", gitsigns.stage_hunk)
        vim.keymap.set('n', "<Leader>hu", gitsigns.reset_hunk)
        vim.keymap.set('n', "<Leader>hk", gitsigns.next_hunk)
        vim.keymap.set('n', "<Leader>hj", gitsigns.prev_hunk)
    end
}
