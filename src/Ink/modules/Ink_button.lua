class "Ink_button"

function Ink_button:Ink_button()
    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.text = "a button"
    self.geometry = "rectangle"

    self.colors = {
        {2, 2, 50},
        {100, 100, 200},
        {150, 150, 220},
        {80, 80, 150}
    }

    self.button_color = self.colors[2]
    self.text_color = self.colors[1]
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
    self.button_color = self.colors[3]

    -- if is on mouse click, execute the MouseClickDown function
    if (love.mouse.isDown(1)) then
        self:MouseClickDown(1)
    end
end

function Ink_button:NotHover ()
    self.button_color = self.colors[2]
end

function Ink_button:MouseClickDown (b)
    self.button_color = self.colors[4]
end

function Ink_button:Ink_Draw ()
    -- Draw button background
    love.graphics.setColor(self.button_color[1], self.button_color[2], self.button_color[3])
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, 100, 100)

    -- Draw button text
    love.graphics.setColor(self.text_color[1], self.text_color[2], self.text_color[3])
    love.graphics.print(self.text, self.pos.x, self.pos.y)
end

return Ink_button()
