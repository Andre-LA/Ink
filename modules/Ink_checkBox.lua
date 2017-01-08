local Checkbox = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
function Checkbox:Start(values, inkLib, name)
    Checkbox(values, inkLib, name)
    -- ink properties:
    self.colors = {
        backgroundColor = {240, 240, 240, 255},
        fillColor = {140, 140, 140, 255}
    }

    self.outlineSize = 4;
end

function Checkbox:MousePressed (x, y, b)
    if self.inHover then
        self.value = not self.value
    end
end

function Checkbox:Ink_Draw ()
    -- Draw background
    love.graphics.setColor(self.colors.backgroundColor)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    -- if value is true, draw the fill
    if self.value then
        love.graphics.setColor(self.colors.fillColor)
        love.graphics.rectangle("fill", self.pos.x + self.outlineSize, self.pos.y + self.outlineSize, self.size.x - 2*self.outlineSize, self.size.y - 2*self.outlineSize)
    end
end

function Checkbox:InvertValue ()
    self.value = not self.value
end

return Checkbox
