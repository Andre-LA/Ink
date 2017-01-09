-- Create 'module's using this as reference
local Geometries = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()

function Geometries:start(values, inkLib, name)
    Geometries(values, inkLib, name)
    self.color = {20,20,20,255}
end

function Geometries:draw ()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
end

return Geometries
