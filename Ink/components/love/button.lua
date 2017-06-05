local Button = {}
Button.__index = Button

function Button:new (ink, element, parameters, name)
    setmetatable(Button, {__index = ink.COMPONENT})
    ink.COMPONENT.new(self, ink, element, parameters.parentId, name)
    setmetatable(self, Button)

    self.colorWhenHover = parameters.colorWhenHover or {255,255,255,0}
    self.colorWhenClicked = parameters.colorWhenClicked or {255,255,255,0}
    self.onClickFunction = parameters.onClickFunction or function(x, y, button, istouch) end
    self.colorToDraw = {0,0,0,0}

    self.isOnHover = false

    return self
end

function Button:mousepressed (x, y, button, istouch)
    if self.isOnHover then
        self.colorToDraw = self.colorWhenClicked
    end
end

function Button:mousereleased(x, y, button, istouch)
    self.colorToDraw = {0,0,0,0}
    if self.isOnHover then
        self.onClickFunction(x, y, button, istouch)
    end
end

function Button:onHover ()
    self.isOnHover = true
end

function Button:none ()
    self.isOnHover = false
end

function Button:draw ()
    love.graphics.setColor(self.colorToDraw)
    love.graphics.rectangle("fill", self.element.rect_transform.position.x, self.element.rect_transform.position.y, self.element.rect_transform.scale.x, self.element.rect_transform.scale.y)
end

return Button
