local rect_transform = {}
rect_transform.__index = rect_transform

function rect_transform.new ()
    local self = {
        entities = {},
        name = "rect_transform",
    }
    setmetatable(self, rect_transform)
    return self
end

function rect_transform.applyParameters (parameters)
    local finalParameters = {
        position = parameters.position or {x = 0, y = 0, z = 0},
        scale    = parameters.cale     or {x = 0, y = 0},
        anchors  = parameters.anchors  or {up = 1, left = 1, right = 1, down = 1},
        offset   = parameters.offset   or {up = 0, left = 0, right = 0, down = 0},
        useTween = parameters.useTween or true,
        velocity = parameters.velocity or 5,
    }
    return finalParameters
end

local function lerp (initial, final, interpolation)
    return initial + (final - initial) * interpolation
end

local function _updatePositionAndScale (ink, entity, dt)
    local entity_rect_transform = entity.rect_transform

    local parentPosition = entity.parentId ~= 0
        and ink:getEntity(entity.parentId).rect_transform.position
        or {x = 0, y = 0}

    local parentScale = entity.parentId ~= 0
        and ink:getEntity(entity.parentId).rect_transform.scale
        or {x = love.graphics.getWidth(), y = love.graphics.getHeight()}

    local originX = parentPosition.x
    local originY = parentPosition.y

    local width = parentScale.x
    local height = parentScale.y

    local finalPosX = (width * (1 - entity_rect_transform.anchors.left)) + entity_rect_transform.offset.left + originX
    local finalPosY = (height * (1 - entity_rect_transform.anchors.up)) + entity_rect_transform.offset.up + originY

    local finalScaleX = width * (1 - ((1 - entity_rect_transform.anchors.right) + (1 - entity_rect_transform.anchors.left))) - entity_rect_transform.offset.left - entity_rect_transform.offset.right
    local finalScaleY = height * (1 - ((1 - entity_rect_transform.anchors.up) + (1 - entity_rect_transform.anchors.down))) - entity_rect_transform.offset.up - entity_rect_transform.offset.down

    if entity_rect_transform.preserve_aspect_ratio then
        if finalScaleX < finalScaleY then
            finalPosY = finalPosY + finalScaleY/2 - finalScaleX/2
            finalScaleY = finalScaleX
        else
            finalPosX = finalPosX + finalScaleX/2 - finalScaleY/2
            finalScaleX = finalScaleY
        end
    end

    if entity_rect_transform.useTween then
        entity_rect_transform.position.x = lerp(entity_rect_transform.position.x, finalPosX, entity_rect_transform.velocity * ink.velocity * dt)
        entity_rect_transform.position.y = lerp(entity_rect_transform.position.y, finalPosY, entity_rect_transform.velocity * ink.velocity * dt)
        entity_rect_transform.scale.x = lerp(entity_rect_transform.scale.x, finalScaleX, entity_rect_transform.velocity * ink.velocity * dt)
        entity_rect_transform.scale.y = lerp(entity_rect_transform.scale.y, finalScaleY, entity_rect_transform.velocity * ink.velocity * dt)
    else
        entity_rect_transform.position.x = finalPosX
        entity_rect_transform.position.y = finalPosY
        entity_rect_transform.scale.x = finalScaleX
        entity_rect_transform.scale.y = finalScaleY
    end
end

function rect_transform.update (ink, entity, dt)
    _updatePositionAndScale(ink, entity, dt)
end

-- example: button.rect_transform.move(hero_id, "offset", 20, 10)
function rect_transform.move (entity, property, deltaX, deltaY)
    entity.rect_transform[property].left  = entity.rect_transform[property].left - deltaX
    entity.rect_transform[property].right = entity.rect_transform[property].right + deltaX
    entity.rect_transform[property].up    = entity.rect_transform[property].up - deltaY
    entity.rect_transform[property].down  = entity.rect_transform[property].down + deltaY
end

function rect_transform.isMouseOver (entity_rect_transform)
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()

    return mouseX > entity_rect_transform.position.x
        and mouseX < entity_rect_transform.position.x + entity_rect_transform.scale.x
        and mouseY > entity_rect_transform.position.y
        and mouseY < entity_rect_transform.position.y + entity_rect_transform.scale.y
end


return rect_transform
