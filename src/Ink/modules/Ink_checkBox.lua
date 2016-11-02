local Module = {}
function Module:New()
    -- ink properties:
    self.parent = "Ink_origin"
    self.parentPos = {x = 0, y = 0}
    self.localPos = {x = 0, y = 0}
    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.isVisible = true
    self.geometry = "rectangle"

    self.value = false
    self.inHover = false

    self.colors = {
        backgroundColor = {240, 240, 240, 255},
        fillColor = {140, 140, 140, 255}
    }

    self.outlineSize = 4;

    local nw = {}
    setmetatable(nw, {__index = self})
    return nw
end

function Module:Set_Parent (name)
    self.parent = name;
end

function Module:Ink_Start (values, inkLib)
    self.inkLib = inkLib

    self.localPos.x = values.positionX
    self.localPos.y = values.positionY
    self.size.x = values.sizeX
    self.size.y = values.sizeY
    self.value = values.value;
    self.outlineSize = values.outlineSize
end

function Module:Update (dt)
end

function Module:Hover ()

end

function Module:NotHover ()

end

function Module:MousePressed (x, y, b)
    if self.inHover then
        self.value = not self.value
    end
end

function Module:MouseDown (x, y, b)

end

function Module:MouseReleased (x, y, b)

end

function Module:TextInput (text)

end

function Module:KeyPressed (key, scancode, isrepeat)

end

function Module:KeyReleased (key)

end

function Module:Ink_Draw ()
    -- Draw background
    love.graphics.setColor(self.colors.backgroundColor)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    -- if value is true, draw the fill
    if self.value then
        love.graphics.setColor(self.colors.fillColor)
        love.graphics.rectangle("fill", self.pos.x + self.outlineSize, self.pos.y + self.outlineSize, self.size.x - 2*self.outlineSize, self.size.y - 2*self.outlineSize)
    end
end

function Module:Get_Value ()
    return self.value
end

function Module:Set_Value (newValue)
    self.value = newValue
end

function Module:InvertValue ()
    self.value = not self.value
end

return Module:New()
