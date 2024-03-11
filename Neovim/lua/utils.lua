local utils = {}

utils.isWSL = function()
    return vim.env.WSL_DISTRO_NAME ~= nil
end

utils.isWindows = function()
    return vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16")
end

return utils
