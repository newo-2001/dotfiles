require("bootstrap")

require("config.options")
require("config.mappings")

require("winbar")

-- Toggle relative line numbers when entering and leaving insert mode
vim.api.nvim_create_autocmd("InsertEnter", { callback = function() vim.opt.relativenumber = false end })
vim.api.nvim_create_autocmd("InsertLeave", { callback = function() vim.opt.relativenumber = true end })

-- Write on :W as well
vim.api.nvim_create_user_command("W", function() vim.api.nvim_command("write") end, {})
