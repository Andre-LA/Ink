class "Ink_button"

function Ink_button:Ink_button()
    self.posX = 0
    self.posY = 0
    self.sizeX = 100
    self.sizeY = 100
    self.text = "a button"
    self.button_color = {100, 100, 200}
    self.text_color = {2, 2, 50}
end

function Ink_button:Start (position, size, text, button_color, text_color)
    self.posX = position[1]
    self.posY = position[2]
    self.sizeX = size[1]
    self.sizeY = size[2]
    self.text = text
end

function Ink_button:Ink_Draw ()
    love.graphics.setColor(self.button_color[1], self.button_color[2], self.button_color[3])
    love.graphics.rectangle("fill", self.posX, self.posY, self.sizeX, self.sizeY)
    love.graphics.setColor(self.text_color[1], self.text_color[2], self.text_color[3])
    love.graphics.print(self.text, self.posX, self.posY)
end

return Ink_button()
