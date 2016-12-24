local Checkcircle = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
-- Create modules using this as reference
function Checkcircle:Start(values, inkLib, name)
    -- ink properties:
    Checkcircle(values, inkLib, name)

    self.colors = {
        backgroundColor = {240, 240, 240, 255},
        fillColor = {140, 140, 140, 255}
    }

    self.outlineSize = 4;
end

function Checkcircle:MousePressed (x, y, b)
    if self.inHover then
        self.value = not self.value
    end
end

function Checkcircle:Ink_Draw ()
    -- Draw background
    love.graphics.setColor(self.colors.backgroundColor)
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.size.x, self.size.x/2)

    -- if value is true, draw the fill
    if self.value then
        love.graphics.setColor(self.colors.fillColor)
        love.graphics.circle("fill", self.pos.x, self.pos.y, self.size.x - 2*self.outlineSize, self.size.x/2)
    end
end

function Checkcircle:InvertValue ()
    self.value = not self.value
end

return Checkcircle
