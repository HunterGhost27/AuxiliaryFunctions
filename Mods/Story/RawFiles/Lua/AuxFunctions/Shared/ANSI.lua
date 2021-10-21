--  =================
--  ANSI ESCAPE CODES
--  =================

---@alias ANSIColor 'black' | 'red' | 'green' | 'yellow' | 'blue' | 'magenta' | 'cyan' | 'white' | 'default' | 'reset' | { r: number, g: number, b: number }

---@class ANSI @Functions to make use of ANSI escape codes
---@field BUFFER string[] Enqueues strings before flushing to stdout
---@field ESC string Escape character string
---@field Color table<ANSIColor, number> Table to map color names to escape codes
ANSI = {
    BUFFER = {},
    ESC = string.char(27),
    Color = {
        black = 30,
        red = 31,
        green = 32,
        yellow = 33,
        blue = 34,
        magenta = 35,
        cyan = 36,
        white = 37,
        default = 39,
        reset = 0,
    },
}

--  WRITE
--  =====

---Enqueue string in BUFFER
---@param str string String to add to the buffer
function ANSI:Enqueue(str) table.insert(self.BUFFER, str) end

---Clear the Buffer
function ANSI:ClearBuffer() self.BUFFER = {} end

---Flushes buffer to stdout
---@param printFn function Print function to use
function ANSI:Flush(printFn)
    printFn = printFn or print
    local str = table.concat(self.BUFFER)
    printFn(str)
    self:ClearBuffer()
end

--  CURSOR MANIPULATION
--  ===================

---Moves the cursor to the home position (0, 0)
---@return string
function ANSI:MoveCursorToHome() return self.ESC .. '[H' end

---Moves the cursor to specified row and column
---@param row integer
---@param column integer
---@return string
function ANSI:MoveCursorTo(row, column)
    row = row or 0
    column = column or 0
    return self.ESC .. '[' .. row .. ';' .. column .. 'H'
end

---Moves cursor up n number of lines (default: 1)
---@param n integer
---@return string
function ANSI:MoveCursorUp(n)
    n = n or 1
    return self.ESC .. '[' .. n .. 'A'
end

---Move cursor down n number of lines (default: 1)
---@param n integer
---@return string
function ANSI:MoveCursorDown(n)
    n = n or 1
    return self.ESC .. '[' .. n .. 'B'
end

---Move cursor right n number of lines (default: 1)
---@param n integer
---@return string
function ANSI:MoveCursorRight(n)
    n = n or 1
    return self.ESC .. '[' .. n .. 'C'
end

---Move cursor left n number of lines (default: 1)
---@param n integer
---@return string
function ANSI:MoveCursorLeft(n)
    n = n or 1
    return self.ESC .. '[' .. n .. 'D'
end

---Move cursor to the beginning of the next line, n lines down (default: 1)
---@param n integer
---@return string
function ANSI:MoveCursorToNextLine(n)
    n = n or 1
    return self.ESC .. '[' .. n .. 'E'
end

---Move cursor to the beginning of the prevous line, n lines up (default: 1)
---@param n integer
---@return string
function ANSI:MoveCursorToPrevLine(n)
    n = n or 1
    return self.ESC .. '[' .. n .. 'F'
end

---Move cursor to column n (default: 0)
---@param n integer
---@return string
function ANSI:MoveCursorToColumn(n)
    n = n or 0
    return self.ESC .. '[' .. n .. 'G'
end

---Returns the cursor position as {ESC}[{row};{column}R
---@return string
function ANSI:RequestCursorPosition() return self.ESC .. '[6n' end

---Makes the cursor invisible
---@return string
function ANSI:HideCursor() return self.ESC .. '[?25l' end

---Makes the cursor visible
---@return string
function ANSI:ShowCursor() return self.ESC .. '[?25h' end

-- function ANSI:SaveCursorPosition() end
-- function ANSI:RestoreCursorPosition() end

--  CLEAR
--  =====

---Clears the screen
---@return string
function ANSI:ClearScreen() return self.ESC .. '[J' end

---Clears from the cursor until the end of the screen
---@return string
function ANSI:ClearCursorAndBelow() return self.ESC .. '[0J' end

---Clears from the cursor to the beginning of the screen
---@return string
function ANSI:ClearCursorAndAbove() return self.ESC .. '[1J' end

---Clears the entire screen
---@return string
function ANSI:ClearEntireScreen() return self.ESC .. '[2J' end

---Clears the current line
---@return string
function ANSI:ClearLine() return self.ESC .. '[K' end

---Clears from the cursor to the end of line
---@return string
function ANSI:ClearLineFromCursor() return self.ESC .. '[0K' end

---Clears from cursor to the start of the line
---@return string
function ANSI:ClearLineToCursor() return self.ESC .. '[1K' end

---Clears the entire line
---@return string
function ANSI:ClearEntireLine() return self.ESC .. '[2K' end

--  COLORS / GRAPHICS FUNCTIONS
--  ===========================

--  Not all sequences are support on all terminals

---Reset all styles and colors
---@return string
function ANSI:Reset() return self.ESC .. '[0m' end

---Set bold
---@return string
function ANSI:SetBold() return self.ESC .. '[1m' end

---Unset bold
---@return string
function ANSI:UnsetBold() return self.ESC .. '[21m' end

---Make the text bold
---@param text string
---@return string
function ANSI:Bold(text) return self:SetBold() .. text .. self:UnsetBold() end

---Set faint
---@return string
function ANSI:SetFaint() return self.ESC .. '[2m' end

---Unset faint
---@return string
function ANSI:UnsetFaint() return self.ESC .. '[22m' end

---Make the text faint
---@param text string
---@return string
function ANSI:Faint(text) return self:SetFaint() .. text .. self:UnsetFaint() end

---Set italic
---@return string
function ANSI:SetItalic() return self.ESC .. '[3m' end

---Unset italic
---@return string
function ANSI:UnsetItalic() return self.ESC .. '[23m' end

---Make the text italic
---@param text string
---@return string
function ANSI:Italic(text) return self:SetItalic() .. text .. self:UnsetItalic() end


---Set underline
---@return string
function ANSI:SetUnderline() return self.ESC .. '[4m' end

---Unset underline
---@return string
function ANSI:UnsetUnderline() return self.ESC .. '[24m' end

---Underline the text
---@param text string
---@return string
function ANSI:Underline(text) return self:SetUnderline() .. text .. self:UnsetUnderline() end

---Set blinking
---@return string
function ANSI:SetBlinking() return self.ESC .. '[5m' end

---Unset blinking
---@return string
function ANSI:UnsetBlinking() return self.ESC .. '[25m' end

---Make the text blink
---@param text string
---@return string
function ANSI:Blinking(text) return self:SetBlinking() .. text .. self:UnsetBlinking() end

---Set inverse
---@return string
function ANSI:SetInverse() return self.ESC .. '[7m' end

---Unset inverse
---@return string
function ANSI:UnsetInverse() return self.ESC .. '[27m' end

---Invert text color
---@param text string
---@return string
function ANSI:Invert(text) return self:SetInverse() .. text .. self:UnsetInverse() end

---Set hidden
---@return string
function ANSI:SetHidden() return self.ESC .. '[8m' end

---Unset hidden
---@return string
function ANSI:UnsetHidden() return self.ESC .. '[28m' end

---Hide the text
---@param text string
---@return string
function ANSI:Hide(text) return self:SetHidden() .. text .. self:UnsetHidden() end

---Set strikethrough
---@return string
function ANSI:SetStrikethrough() return self.ESC .. '[9m' end

---Unset strikethrough
---@return string
function ANSI:UnsetStrikethrough() return self.ESC .. '[29m' end

---Strikethrough the text
---@param text string
---@return string
function ANSI:Strikethrough(text) return self:SetStrikethrough() .. text .. self:UnsetStrikethrough() end

---Set color to the given text
---@param text string
---@param color ANSIColor
---@param isBackground boolean
---@param isBright boolean
---@return string
function ANSI:SetColor(text, color, isBackground, isBright)
    local ansiColor
    if type(color) == 'string' then
        ansiColor = self.Color[color] + (isBackground and 10 or 0) + (isBright and 60 or 0)
        return self.ESC .. '[' .. ansiColor .. 'm' .. text .. self:Reset()
    else
        if (color.r < 0 or color.r > 255) or (color.g < 0 or color.g > 255) or (color.b < 0 or color.b > 255) then return text end -- Check if RGB values are valid
        ansiColor = isBackground and '48' or '38' -- Select background vs foreground variants
        return self.ESC .. '[' .. ansiColor .. ';2;' .. tostring(color.r) .. ';' .. tostring(color.g) .. ';' .. tostring(color.b) .. 'm' .. text .. self:Reset()
    end
end

--  MISCELLANEOUS
--  =============

---Save the screen
---@return string
function ANSI:SaveScreen() return self.ESC .. '[?47h' end

---Restore the screen
---@return string
function ANSI:RestoreScreen() return self.ESC .. '[?47l' end

---Enables the alternate buffer
---@return string
function ANSI:EnableAltBuffer() return self.ESC .. '[?1049h' end

---Disables the alternate buffer
---@return string
function ANSI:DisableAltBuffer() return self.ESC .. '[?1049l' end

--  UTILITIES
--  =========

---Write string with given colors
---@param str string
---@param color ANSIColor
---@param isBackground boolean
---@param isBright boolean
function ANSI:Write(str, color, isBackground, isBright)
    self:Enqueue(self:SetColor(str, color, isBackground, isBright))
end

---Write string with given colors
---@param str string
---@param color ANSIColor
---@param isBackground boolean
---@param isBright boolean
function ANSI:WriteLine(str, color, isBackground, isBright)
    self:Enqueue(self:SetColor(str, color, isBackground, isBright) .. '\n')
end