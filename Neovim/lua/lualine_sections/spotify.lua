local Job = require("plenary.job")
local now_playing = ""
local last_update = 0

local function is_remix(track)
    local remix_patterns = {
        " [-–] (.*) [Rr]emix",
        " [-–] [Rr]emix",
    }

    for _, pattern in pairs(remix_patterns) do
        local start_match, _, remix_artist = track:find(pattern)
        if start_match ~= nil then
            return true, remix_artist
        end
    end

    return false
end

local function remove_patterns(str, patterns)
    for _, pattern in pairs(patterns) do
        str = str:gsub(pattern, "")
    end

    return str
end

-- TODO: Lua's pattern matching functions work byte-by-byte
-- therefor this function can produce spurious results for UTF-8 strings.
local function format_track(artist, track)
    -- Replace artist with the remixer if this is a remix
    local remixed, remix_artist = is_remix(track)
    if remix_artist ~= nil then artist = remix_artist end

    -- Filter superfluous info from the artist
    artist = remove_patterns(artist, {
        " ?[%(%[（［][Cc][Vv][%.:].+[%)%]）］]",
        "&.*"
    })

    -- Filter superfluous info from the track
    track = remove_patterns(track, {
        "%(.*%)",
        "%[.*%]",
        " [%-–~～:|] .*",
        "%-.+%-",
        "–.+–",
        "~.+~",
        "～.+～"
    })

    return artist .. (remixed and " 󰒟 " or " - ") .. track
end

-- https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/src/segments/spotify_wsl.go
local function update()
    local output = ""
    Job:new({
        command = "tasklist.exe",
        args = { "/V", "/FI", "Imagename eq Spotify.exe", "/FO", "CSV", "/NH" },
        on_stdout = function(_, line)
            output = output .. line .. "\r\n"
        end,
        on_exit = function()
            if output:find("^INFO") == nil then
                for row in output:gmatch("[^\r\n]+") do
                    for field in row:gmatch("[^,]+") do
                        field = field:sub(2, #field - 1)

                        local delim_start, delim_end = field:find(" %- ")
                        if delim_end ~= nil then
                            local artist = field:sub(1, delim_start - 1)
                            local track = field:sub(delim_end + 1, #field)
                            now_playing = "󰓇 " .. format_track(artist, track)
                            return
                        end
                    end
                end
            end

            now_playing = ""
        end
    }):start()
end

return function()
    local time = vim.loop.now()
    if time - last_update > 3000 then
        last_update = time
        update()
    end

    return now_playing
end
