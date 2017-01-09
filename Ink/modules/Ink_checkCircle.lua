local Checkcircle = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
-- Create modules using this as reference
function Checkcircle:start(values, inkLib, name)
    -- ink properties:
    self.outlineSize = 4;
    self.colors = {
        backgroundColor = {240, 240, 240, 255},
        fillColor = {140, 140, 140, 255},
        outlineColor = {200,200,200,255}
    }
    Checkcircle(values, inkLib, name)
    self.geometry = "circle"
end

function Checkcircle:mousepressed (x, y, b, ist, name)
    if self.inHover then
        self.value = not self.value
    end
end

function Checkcircle:hover ()
    self.colors.outlineColor = {200,200,200,255}
end

function Checkcircle:nothover ()
    self.colors.outlineColor = {200,200,200,0}
end

function Checkcircle:draw ()
    -- Draw background
    love.graphics.setColor(self.colors.backgroundColor)
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.size.x)

    love.graphics.setColor(self.colors.outlineColor)
    for i=1,self.outlineSize*0.8 do
        love.graphics.circle("line", self.pos.x, self.pos.y-i, self.size.x-i)
    end

    -- if value is true, draw the fill
    if self.value then
        love.graphics.setColor(self.colors.fillColor)
        love.graphics.circle("fill", self.pos.x, self.pos.y, self.size.x - 2*self.outlineSize)
    end
end

function Checkcircle:invertValue ()
    self.value = not self.value
end

return Checkcircle
