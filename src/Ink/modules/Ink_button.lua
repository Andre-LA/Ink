class "Ink_button"

function Ink_button:Ink_button()
    self.posX = 0
    self.posY = 0
    self.sizeX = 100
    self.sizeY = 100
    self.text = "a button"

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
    self.posX = position[1]
    self.posY = position[2]
    self.sizeX = size[1]
    self.sizeY = size[2]
    self.text = text
end

function Ink_button:Ink_VerifyHover ()
    local mousePosx, mousePosy = love.mouse.getPosition()
    local ret = false;

    if (mousePosx > self.posX and mousePosx < self.posX + self.sizeX) and
    (mousePosy > self.posY and mousePosy < self.posY + self.sizeY) then
        ret = true
    end

    return ret
end

function Ink_button:Update (dt)

end

function Ink_button:Hover ()
    self.button_color = self.colors[3]
end

function Ink_button:NotHover ()
    self.button_color = self.colors[2]
end

function Ink_button:MouseClickDown (b)
    self.button_color = self.colors[4]
end

function Ink_button:Ink_Draw ()
    love.graphics.setColor(self.button_color[1], self.button_color[2], self.button_color[3])
    love.graphics.rectangle("fill", self.posX, self.posY, self.sizeX, self.sizeY)
    love.graphics.setColor(self.text_color[1], self.text_color[2], self.text_color[3])
    love.graphics.print(self.text, self.posX, self.posY)
end

return Ink_button()
