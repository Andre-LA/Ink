class "Ink_empty"

-- Create modules using this as reference

function Ink_empty:Ink_empty()
    -- ink properties:
    self.parent = ""
    self.parentPos = {x = 0, y = 0}
    self.isVisible = true
    self.geometry = "none"
    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.value = "hi ^-^" --the .value property can be any type of value (number, string, function, etc)
    self.inHover = false
end

function Ink_empty:Update_Parent (parent)
    self.parentPos = parent
end

function Ink_empty:Set_Parent (name)
    self.parent = name;
end

function Ink_empty:Ink_Start (values, inkLib)
    self.inkLib = inkLib

    self.pos.x = values.positionX
    self.pos.y = values.positionY
    self.size.x = values.sizeX
    self.size.y = values.sizeY
    self.text = values.text
    self.value = values.value;
end

function Ink_empty:Update (dt)

end

function Ink_empty:Hover ()

end

function Ink_empty:NotHover ()

end

function Ink_empty:MousePressed (x, y, b)

end

function Ink_empty:MouseDown (x, y, b)

end

function Ink_empty:MouseReleased (x, y, b)

end

function Ink_empty:TextInput (text)

end

function Ink_empty:KeyPressed (key, scancode, isrepeat)

end

function Ink_empty:KeyReleased (key)

end

function Ink_empty:Ink_Draw ()

end

function Ink_empty:Get_Value ()
    return self.value
end

function Ink_empty:Set_Value (newValue)
    self.value = newValue
end

return Ink_empty()
