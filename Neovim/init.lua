require("bootstrap")

require("config.options")
require("config.mappings")

require("winbar")

vim.api.nvim_create_autocmd("InsertEnter", { callback = function() vim.opt.relativenumber = false end })
vim.api.nvim_create_autocmd("InsertLeave", { callback = function() vim.opt.relativenumber = true end })
