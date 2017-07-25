local rect_transform = {}
rect_transform.__index = rect_transform
local ink = {}

function rect_transform.new (_ink)
    local self = {
        entities = {},
        name = "rect_transform",
        requires = {"rect_transform"}
    }
    ink = _ink
    setmetatable(self, rect_transform)
    return self
end

local function lerp (initial, final, interpolation)
    return initial + (final - initial) * interpolation
end

local function _updatePositionAndScale (entity, dt)
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

    local finalPosX = (width * (1 - entity.rect_transform.anchors.left)) + entity.rect_transform.offset.left + originX
    local finalPosY = (height * (1 - entity.rect_transform.anchors.up)) + entity.rect_transform.offset.up + originY

    local finalScaleX = width * (1 - ((1 - entity.rect_transform.anchors.right) + (1 - entity.rect_transform.anchors.left))) - entity.rect_transform.offset.left - entity.rect_transform.offset.right
    local finalScaleY = height * (1 - ((1 - entity.rect_transform.anchors.up) + (1 - entity.rect_transform.anchors.down))) - entity.rect_transform.offset.up - entity.rect_transform.offset.down

    if entity.rect_transform.preserve_aspect_ratio then
        if finalScaleX < finalScaleY then
            finalPosY = finalPosY + finalScaleY/2 - finalScaleX/2
            finalScaleY = finalScaleX
        else
            finalPosX = finalPosX + finalScaleX/2 - finalScaleY/2
            finalScaleX = finalScaleY
        end
    end

    if entity.rect_transform.useTween then
        entity.rect_transform.position.x = lerp(entity.rect_transform.position.x, finalPosX, entity.rect_transform.velocity * ink.velocity * dt)
        entity.rect_transform.position.y = lerp(entity.rect_transform.position.y, finalPosY, entity.rect_transform.velocity * ink.velocity * dt)
        entity.rect_transform.scale.x = lerp(entity.rect_transform.scale.x, finalScaleX, entity.rect_transform.velocity * ink.velocity * dt)
        entity.rect_transform.scale.y = lerp(entity.rect_transform.scale.y, finalScaleY, entity.rect_transform.velocity * ink.velocity * dt)
    else
        entity.rect_transform.position.x = finalPosX
        entity.rect_transform.position.y = finalPosY
        entity.rect_transform.scale.x = finalScaleX
        entity.rect_transform.scale.y = finalScaleY
    end
end

function rect_transform.update (entity, dt)
    _updatePositionAndScale(entity, dt)
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
