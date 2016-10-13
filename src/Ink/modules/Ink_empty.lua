class "Ink_empty"

-- Create modules using this as reference

function Ink_button:Ink_button()
    -- ink properties:
    self.parent = ""
    self.parentPos = {x = 0, y = 0}
    self.isVisible = true
    self.geometry = "rectangle"
    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.value = "hi ^-^" --the .value property can be any type of value (number, string, function, etc)
end

function Ink_button:Update_Parent (parent)
    self.parentPos = parent
end

function Ink_button:Set_Parent (name)
    self.parent = name;
end

function Ink_button:Ink_Start (values, inkLib)
    self.inkLib = inkLib

    self.pos.x = values.positionX
    self.pos.y = values.positionY
    self.size.x = values.sizeX
    self.size.y = values.sizeY
    self.text = values.text
    self.value = values.value;
end

function Ink_button:Update (dt)

end

function Ink_button:Hover ()

end

function Ink_button:NotHover ()

end

function Ink_button:MousePressed (x, y, b)

end

function Ink_button:MouseDown (x, y, b)

end

function Ink_button:MouseReleased (x, y, b)

end

function Ink_button:Ink_Draw ()
end

function Ink_button:Get_Value ()
    return self.value
end

function Ink_button:Set_Value (newValue)
    self.value = newValue
end

return Ink_button()
