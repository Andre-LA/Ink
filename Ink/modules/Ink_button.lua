--module "Ink_button"
local Button = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
function Button:start (values, inkLib, name)
    Button(values, inkLib, name)
    self.pivot = {x = 0.5, y = 0.5}

    self.colors = {
        {250, 250, 250},
        {100, 100, 200},
        {150, 150, 220},
        { 80,  80, 150}
    }

    self.button_color = self.colors[2]
    self.text_color = self.colors[1]
end

function Button:hover ()
    if self.button_color ~= self.colors[4] then
        self.button_color = self.colors[3]
    end
end

function Button:nothover ()
    self.button_color = self.colors[2]
end

function Button:mousepressed (x, y, b)
    if self.inHover then
        self.button_color = self.colors[4]
        self:value()
    end
end

function Button:mousereleased (x, y, b)
    if self.inHover then
        self.button_color = self.colors[3]
    end
end

function Button:draw ()
    -- Draw button background
    love.graphics.setColor(self.button_color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    -- Draw button text, the text position = button position + (button size * pivot) - half size of the button text
    love.graphics.setColor(self.text_color)
    love.graphics.print(self.text, self.pos.x + (self.size.x * self.pivot.x) - (love.graphics.getFont():getWidth(self.text)/2), self.pos.y + (self.size.y * self.pivot.y) - (love.graphics.getFont():getHeight("a")/2))
end

function Button:setText (text)
    self.text = text
end

return Button
