local utils = {}

utils.isWSL = function()
    return vim.env.WSL_DISTRO_NAME ~= nil
end

return utils
