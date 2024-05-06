local utils = {}

utils.is_wsl = function()
    return vim.env.WSL_DISTRO_NAME ~= nil
end

utils.is_windows = function()
    return (vim.fn.has("win64") or vim.fn.has("win32") or vim.fn.has("win16")) ~= 0
end

utils.is_linux = function() return not utils.is_windows() end

utils.deep_copy = function(obj)
    if type(obj) ~= "table" then return obj end

    local copy = {}
    for k, v in pairs(obj) do
        if type(v) == "table" then
            v = utils.deep_copy(v)
        end

        copy[k] = v
    end

    return copy
end

utils.merge_tables = function(...)
    local args = { ... }
    local merged = {}
    for _, table in pairs(args) do
        for k, v in pairs(table) do
            if merged[k] == nil then merged[k] = v end
        end
    end

    return merged
end

local distro = nil
utils.linux_distro = function()
    if distro == nil and utils.is_linux() then
        local file = io.open("/etc/os-release")
        local _, line = file:read(), file:read()

        distro = line:match('"([^"]+)"')

        file:close()
    end

    return distro
end

return utils
