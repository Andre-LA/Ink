local Text = {}
Text.__index = Text

function Text:new(ink, element, parameters, name)
    setmetatable(Text, {__index = ink.COMPONENT})
    ink.COMPONENT.new(self, ink, element, parameters.parentId, name)
    setmetatable(self, Text)

    self.font = parameters.font or love.graphics.getFont()
    self.text = parameters.text or ""
    self.horizontalAlign = parameters.horizontalAlign or "left"
    self.verticalAlign = parameters.verticalAlign or "up"
    self.rotation = parameters.rotation or 0
    self.scale = parameters.scale or {x=1, y=1}
    self.offsets = parameters.offsets or {x=0, y=0}
    self.shearing = parameters.shearing or {x=0, y=0}

    return self
end

function Text:update (dt)
    if self.verticalAlign == "up" then
        self.posY = self.element.rect_transform.position.y
    elseif self.verticalAlign == "center" then
        self.posY = self.element.rect_transform.position.y + self.element.rect_transform.scale.y/2 - self.font:getHeight()/2
    end
end

function Text:draw()
    local previousFont = love.graphics.getFont()
    love.graphics.setFont(self.font)

    love.graphics.printf(self.text, self.element.rect_transform.position.x, self.posY, self.element.rect_transform.scale.x, self.horizontalAlign, self.rotation, self.scale.x, self.scale.y, self.offsets.x, self.offsets.y, self.shearing.x , self.shearing.y)

    love.graphics.setFont(previousFont)
end

return Text
