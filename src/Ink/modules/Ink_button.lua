class "Ink_button"

function Ink_button:Ink_button()
    -- ink properties:
    self.parent = ""
    self.parentPos = {x = 0, y = 0}
    self.isVisible = true
    self.geometry = "rectangle"
    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.value = function  () --the .value property can be any type of value (number, string, function, etc)

    end

    -- My properties
    self.pivot = {x = 0.5, y = 0.5}
    self.text = "a button"

    self.colors = {
        {250, 250, 250},
        {100, 100, 200},
        {150, 150, 220},
        {80, 80, 150}
    }

    self.button_color = self.colors[2]
    self.text_color = self.colors[1]
end

-- All of these functions are obrigatory (can have nothing, like the Update)
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
    -- If you will not use a function, you can write nothing inside, but is obrigatory the module have the function

end

function Ink_button:Hover ()
    if self.button_color ~= self.colors[4] then
        self.button_color = self.colors[3]
    end
end

function Ink_button:NotHover ()
    self.button_color = self.colors[2]
end

function Ink_button:MousePressed (x, y, b)
    self.button_color = self.colors[4]
    self.value()
end

function Ink_button:MouseDown (x, y, b)

end

function Ink_button:MouseReleased (x, y, b)
    self.button_color = self.colors[3]
end

function Ink_button:Ink_Draw ()
    -- Draw button background
    love.graphics.setColor(self.button_color[1], self.button_color[2], self.button_color[3])
    love.graphics.rectangle("fill", self.pos.x + self.parentPos.x, self.pos.y + self.parentPos.y, self.size.x, self.size.y)

    -- Draw button text, the text position = button position + (button size * pivot) - half size of the button text
    love.graphics.setColor(self.text_color[1], self.text_color[2]
    , self.text_color[3])
    love.graphics.print(self.text, self.pos.x + (self.size.x * self.pivot.x) - (love.graphics.getFont():getWidth("a") * #self.text/2) + self.parentPos.x, self.pos.y + (self.size.y * self.pivot.y) - (love.graphics.getFont():getHeight("a")/2) + self.parentPos.y)
end

function Ink_button:GetValue ()
    return self.value
end

function Ink_button:SetValue (newValue)
    self.value = newValue
end

return Ink_button()
