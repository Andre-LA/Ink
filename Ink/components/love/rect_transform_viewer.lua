local RectTransformViewer = {}
RectTransformViewer.__index = RectTransformViewer

function RectTransformViewer:new (ink, element, parameters)
    setmetatable(RectTransformViewer, {__index = ink.COMPONENT})
    ink.COMPONENT.new(self, ink, element, 200, parameters.parentId)
    setmetatable(self, RectTransformViewer)

    return self
end

function RectTransformViewer:draw ()
    if self.ink.devMode then
        love.graphics.rectangle("line", self.element.rect_transform.position.x, self.element.rect_transform.position.y, self.element.rect_transform.scale.x, self.element.rect_transform.scale.y)
        love.graphics.print(self.element.name, self.element.rect_transform.position.x, self.element.rect_transform.position.y)
    end
end

return RectTransformViewer
