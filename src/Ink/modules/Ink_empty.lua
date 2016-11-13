-- Create modules using this as reference
local Module = {}
function Module:New()
    -- ink properties:
    self.parent = "Ink_origin"
    self.parentPos = {x = 0, y = 0}
    self.localPos = {x = 0, y = 0}
    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.isVisible = true
    self.geometry = "none"

    self.value = "hi ^-^" --the .value property can be any type of value (number, string, function, etc)
    self.inHover = false

    local nw = {}
    setmetatable(nw, {__index = self})
    return nw
end

function Module:Set_Parent (name)
    self.parent = name;
end

function Module:Ink_Start (values, inkLib)
    self.inkLib = inkLib

    self.localPos.x = values.position[1]
    self.localPos.y = values.position[2]
    self.size.x = values.size[1]
    self.size.y = values.size[2]
    self.value = values.value;
end

function Module:Update (dt)

end

function Module:Hover ()

end

function Module:NotHover ()

end

function Module:MousePressed (x, y, b)

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

end

function Module:Get_Value ()
    return self.value
end

function Module:Set_Value (newValue)
    self.value = newValue
end

return Module:New()
