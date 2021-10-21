local ansiKeys = {
    --  Reset
    reset = 0,

    --  Misc
    bright = 1,
    dim = 2,
    underline = 3,
    blink = 4,
    reverse = 7,
    hidden = 8,

    --  Foreground Colors
    black = 30,
    red = 31,
    green = 32,
    yellow = 33,
    blue = 34,
    magenta = 35,
    cyan = 36,
    white = 37,

    --  Background Colors
    bgBlack = 40,
    bgRed = 41,
    bgGreen = 42,
    bgYellow = 43,
    bgBlue = 44,
    bgMagenta = 45,
    bgCyan = 36,
    bgWhite = 47
}

local escapeString = string.char(27) .. '[%dm'
local escapeNumber = function (number)
    return escapeString:format(number)
end

local function escapeKeys(str)
    local buffer = {}

    for word in str:gmatch("%w+") do
        local number = ansiKeys[word]
        assert(number, 'Unknown key: ' .. word)
        table.insert(buffer, escapeNumber(number))
    end

    return table.concat(buffer)
end

local function replaceCodes(str)
    str = str:gsub("(%%{(.-)})", function (_, str) return escapeKeys(str) end)
    return str
end

local function ansicolors(str)
    str = tostring(str) or ''
    return replaceCodes('%{reset}' .. str .. '%{reset}')
end