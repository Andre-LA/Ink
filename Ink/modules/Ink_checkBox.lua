local Checkbox = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
function Checkbox:start(values, inkLib, name)
    self.colors = {
        backgroundColor = {240, 240, 240, 255},
        fillColor = {140, 140, 140, 255},
        outlineColor = {200,200,200,255}
    }
    self.outlineSize = 4;
    Checkbox(values, inkLib, name)
end

function Checkbox:mousepressed (x, y, b)
    if self.inHover then
        self.value = not self.value
    end
end

function Checkbox:hover ()
    self.colors.outlineColor = {200,200,200,255}
end

function Checkbox:nothover ()
    self.colors.outlineColor = {200,200,200,0}
end

function Checkbox:draw ()
    -- Draw background
    love.graphics.setColor(self.colors.backgroundColor)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    love.graphics.setColor(self.colors.outlineColor)
    for i=1,self.outlineSize*0.55 do
        love.graphics.rectangle("line", self.pos.x+i-1, self.pos.y+i-1, self.size.x-i*2+2, self.size.y-i*2+2)
    end

    -- if value is true, draw the fill
    if self.value then
        love.graphics.setColor(self.colors.fillColor)
        love.graphics.rectangle("fill", self.pos.x + self.outlineSize, self.pos.y + self.outlineSize, self.size.x - 2*self.outlineSize, self.size.y - 2*self.outlineSize)
    end
end

function Checkbox:invertValue ()
    self.value = not self.value
end

return Checkbox
