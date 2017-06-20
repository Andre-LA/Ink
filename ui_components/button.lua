local button = {}
button.__index = button

function button.new ()
    local self = {
        entities = {},
        name = "button",
    }
    setmetatable(self, button)
    return self
end

function button.applyParameters (parameters)
    local finalParameters = {
        color = parameters.color or {255,255,255,0},
        mouseOverColor = parameters.mouseOverColor or {255,255,255,80},
        onClickColor = parameters.onClickColor or {0,0,0,80},
        finalColor = {0,0,0,255},
        onClick = parameters.onClick or function() end,
        offClick = parameters.offClick or function() end,
        isMouseOver = false,
    }
    return finalParameters
end

function button.update (ink, entity)
    local entity_button = entity.button

    entity_button.isMouseOver = ink:getComponent("rect_transform").isMouseOver(entity.rect_transform)
    entity_button.finalColor = entity_button.isMouseOver and entity_button.mouseOverColor or entity_button.color
end

function button.mousepressed (ink, entity)
    local entity_button = entity.button

    if entity_button.isMouseOver then
        entity_button.finalColor = entity_button.onClickColor
    end
end

function button.mousereleased(ink, entity, x, y, button, istouch)
    local entity_button = entity.button

    if entity_button.isMouseOver then
        entity_button.onClick(ink, entity, x, y, button, istouch)
    else
        entity_button.offClick(ink, entity, x, y, button, istouch)
    end
end

function button.draw (ink, entity)
    local entity_button = entity.button
    local entity_rect_transform = entity.rect_transform

    local color = (love.mouse.isDown(1) and entity_button.isMouseOver)
                    and entity_button.onClickColor
                    or entity_button.finalColor
    love.graphics.setColor(color)
    love.graphics.rectangle("fill",
        entity_rect_transform.position.x, entity_rect_transform.position.y,
        entity_rect_transform.scale.x, entity_rect_transform.scale.y
    )
end

return button
