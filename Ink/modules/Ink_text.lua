-- Create modules using this as reference
local Text = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
function Text:start(values, inkLib, name)
    Text(values, inkLib, name)
    self.color = {0,0,0,255}
end

function Text:draw ()
    -- Saves the Ink font for reset in the end
    local previousFont = self.inkLib.font

    -- Sets the font of the instance
    love.graphics.setFont(self.font)

    -- Set the color of the font
    love.graphics.setColor(self.color)

    -- Draw the text
    love.graphics.print(self.value, self.pos.x, self.pos.y, self.rotation, self.size.x, self.size.y)

    -- Reset font
    love.graphics.setFont(previousFont)
end

return Text
