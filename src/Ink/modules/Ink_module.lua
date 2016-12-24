-- Create modules using this as reference
local Module = {}
setmetatable(Module, {
    __call = function  (cls, ...)
        return cls:New(...)
    end
})

function Module:New (values, inkLib, name)
    -- Default properties:
    self.parent    = "Ink_origin"
    self.parentPos = {x = 0, y = 0}
    self.pos       = {x = 0, y = 0}
    self.size      = {x = 0, y = 0}
    self.isVisible = true
    self.geometry  = "rectangle"
    self.inHover   = false

    -- Variable properties:
    self.name = name
    self.value = values.value
    self.localPos = {x = values.position[1], y = values.position[2]}
    self.localSize = {x = values.size[1], y = values.size[2]}
    self.inkLib = inkLib

    -- Create extra or replace properties:
    for k,v in pairs(values) do
        if k ~= "position" and k ~= "size" and k ~= "name" and k ~= "value" then
            self[k] = v
        end
    end
end

function Module:Get_Global_Position ()
    return self.pos.x, self.pos.y
end

function Module:Get_Local_Position ()
    return self.localPos.x, self.localPos.y
end

function Module:Set_Position (x, y)
    self.localPos.x = x
    self.localPos.y = y
end

function Module:Translate (translate)
    self.localPos.x = self.localPos.x + translate[1]
    self.localPos.y = self.localPos.y + translate[2]
end

function Module:Set_Parent (name)
    self.parent = name;
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

return Module
