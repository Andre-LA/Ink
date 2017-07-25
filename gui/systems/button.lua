local button = {}
button.__index = button
local ink = {}

function button.new (_ink)
    local self = {
        entities = {},
        name = "button",
        requires = {"button", "rect_transform"}
    }
    ink = _ink
    setmetatable(self, button)
    return self
end

function button.update (entity)
    entity.button.isMouseOver = ink:getSystem("rect_transform").isMouseOver(entity.rect_transform)
    entity.button.finalColor = entity.button.isMouseOver and entity.button.mouseOverColor or entity.button.color
end

function button.mousepressed (entity)
    if entity.button.isMouseOver and entity.button.clickable then
        entity.button.finalColor = entity.button.onClickColor
    end
end

function button.mousereleased(entity, x, y, btn, istouch)
    if entity.button.clickable then
        if entity.button.isMouseOver then
            entity.button.onClick(ink, entity, x, y, btn, istouch)
        else
            entity.button.offClick(ink, entity, x, y, btn, istouch)
        end
    end
end

function button.draw (entity)
    local color = (love.mouse.isDown(1) and entity.button.isMouseOver)
                    and entity.button.onClickColor
                    or entity.button.finalColor

    love.graphics.setColor(color)
    love.graphics.rectangle("fill",
        entity.rect_transform.position.x, entity.rect_transform.position.y,
        entity.rect_transform.scale.x, entity.rect_transform.scale.y
    )
end

return button
