class "Ink_button"

function Ink_button:Ink_button()
    self.parent = ""
    self.parentPos = {x = 0, y = 0}

    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.pivot = {x = 0.5, y = 0.5}
    self.text = "a button"
    self.geometry = "rectangle"

    self.colors = {
        {250, 250, 250},
        {100, 100, 200},
        {150, 150, 220},
        {80, 80, 150}
    }

    self.button_color = self.colors[2]
    self.text_color = self.colors[1]
end

function Ink_button:Update_Parent (parent)
    self.parentPos = parent
end

function Ink_button:Set_Parent (name)
    self.parent = name;
end

function Ink_button:Ink_Start (position, size, text, button_color, text_color)
    self.pos.x = position[1]
    self.pos.y = position[2]
    self.size.x = size[1]
    self.size.y = size[2]
    self.text = text
end

function Ink_button:Update (dt)
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
    self.pos.x = self.pos.x + 10
end

function Ink_button:MouseReleased (x, y, b)
    self.button_color = self.colors[3]
end

function Ink_button:Ink_Draw ()
    -- Draw button background
    love.graphics.setColor(self.button_color[1], self.button_color[2], self.button_color[3])
    love.graphics.rectangle("fill", self.pos.x + self.parentPos.x, self.pos.y + self.parentPos.y, self.size.x, self.size.y)

    -- Draw button text, the text position = button position + (button size * pivot) - half size of the button text
    love.graphics.setColor(self.text_color[1], self.text_color[2], self.text_color[3])
    love.graphics.print(self.text, self.pos.x + (self.size.x * self.pivot.x) - (love.graphics.getFont():getWidth("a") * #self.text/2) + self.parentPos.x, self.pos.y + (self.size.y * self.pivot.y) - (love.graphics.getFont():getHeight("a")/2) + self.parentPos.y)
end

return Ink_button()
