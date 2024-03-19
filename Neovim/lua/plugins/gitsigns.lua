return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns");
        gitsigns.setup({
            preview_config = {
                border = "rounded"
            }
        });
    end
}
