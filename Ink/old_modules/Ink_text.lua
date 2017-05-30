-- Create modules using this as reference
local Text = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
function Text:start(values, inkLib, name)
    self.color = {255, 255, 255, 255}
    self.usePrintf = false
    self.rotation = 0
    Text(values, inkLib, name)
    self.font = self.font or inkLib.font
end

function Text:setText (text)
    self.value = text
    self.size.x = self.font:getWidth(text)
    self.size.y = self.font:getHeight(text)
end

function Text:draw ()
    -- Saves the Ink font for reset in the end
    local previousFont = self.inkLib.font

    -- Sets the font of the instance
    love.graphics.setFont(self.font)

    -- Set the color of the font
    love.graphics.setColor(self.color)

    -- Draw the text
    if self.usePrintf then
        love.graphics.printf(self.value, self.pos.x, self.pos.y, self.limit, self.align or "left", self.rotation, 1, 1, self.ox or 0, self.oy or 0, self.kx or 0, self.ky or 0)
    else
        love.graphics.print(self.value, self.pos.x, self.pos.y, self.rotation, 1, 1)
    end
    -- Reset font
    love.graphics.setFont(previousFont)
end

return Text
