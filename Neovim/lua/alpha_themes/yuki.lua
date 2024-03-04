local colors = require("config.theme").colors

vim.api.nvim_set_hl(0, "YukiLogo1", { fg = colors.neovim_blue })
vim.api.nvim_set_hl(0, "YukiLogo2", { fg = colors.neovim_green, bg = colors.neovim_blue })
vim.api.nvim_set_hl(0, "YukiLogo3", { fg = colors.neovim_green })
vim.api.nvim_set_hl(0, "YukiSubtitle", { fg = colors.snowy })
vim.api.nvim_set_hl(0, "YukiQuote", { fg = colors.snowy, italic = true })

-- Redraw when clock changes
local timer = nil
vim.api.nvim_create_autocmd("User", { callback = function(args)
    if args.match == "AlphaReady" then
        -- Couldn't find a normal way to get the time (╥_╥)
        local timeout = (60 - tonumber(vim.fn.strftime("%S"))) * 1000

        timer = vim.loop.new_timer()
        timer:start(timeout, 60 * 1000, vim.schedule_wrap(function()
            require("alpha").redraw()
        end))
    elseif args.match == "AlphaClosed" and timer ~= nil then
        timer:stop()
        timer:close()
        timer = nil
    end
end })

local header = {
    type = "text",
    val = {
        "     █  █     ",
        "     ██ ██     ",
        "     █████     ",
        "     ██ ███     ",
        "     █  █     "
    },
    opts = {
        position = "center",
        hl = {
            { { "YukiLogo1", 6, 8  }, { "YukiLogo3", 9,  22 } },
            { { "YukiLogo1", 6, 8  }, { "YukiLogo2", 9,  11 }, { "YukiLogo3", 12, 24 } },
            { { "YukiLogo1", 6, 11 }, { "YukiLogo3", 12, 26 } },
            { { "YukiLogo1", 6, 11 }, { "YukiLogo3", 12, 24 } },
            { { "YukiLogo1", 6, 11 }, { "YukiLogo3", 12, 22 } },
        }
    }
}

local function button(text, shortcut, action)
    return {
        type = "button",
        val = text,
        on_press = action,
        opts = {
            position = "center",
            width = 50,
            cursor = 2,
            shortcut = shortcut,
            align_shortcut = "right",
            keymap = { 'n', shortcut, action }
        }
    }
end

local menu = {
    type = "group",
    val = {
        button("󰦛 > Recent file", 'r', require("telescope.builtin").oldfiles),
        button("󰍉 > Find file", 'f', require("telescope.builtin").find_files),
        button(" > Plugins", 'p', require("lazy").home),
        button("󰗼 > Quit", 'q', function() vim.cmd("q") end)
    },
    opts = {
        spacing = 1
    }
}

local plugin_count = tostring(#(require("lazy").plugins()))
local version = vim.version()
version = string.format("%d.%d.%d", version.major, version.minor, version.patch)

local quotes = {
    "An elegant weapon for a more civilized age",
    "Memento mori",
    "Did you mean: emacs",
}

return {
    opts = {
        margin = 5
    },
    layout = {
        { type = "padding", val = 2 },
        header,
        { type = "padding", val = 1 },
        {
            type = "text",
            val = "雪 Yuki",
            opts = {
                position = "center",
                hl = "YukiSubtitle"
            }
        },
        { type = "padding", val = 3 },
        menu,
        { type = "padding", val = 3 },
        {
            type = "text",
            val = function() return vim.fn.strftime(" %Y-%m-%d   %H:%M") .. "   " .. plugin_count .. " plugins   " .. version end,
            opts = {
                position = "center",
                hl = "YukiSubtitle"
            }
        },
        { type = "padding", val = 1 },
        {
            type = "text",
            val = quotes[math.random(#quotes)],
            opts = {
                position = "center",
                hl = "YukiQuote"
            }
        }
    }
}
