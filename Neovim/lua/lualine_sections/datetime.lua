local WEEKDAYS = { "月", "火", "水", "木", "金", "土", "日" }

return function()
    local weekday = WEEKDAYS[tonumber(os.date("%w"))]

    return os.date("%m月%d日（" .. weekday .. "）%H:%M")
end
