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

local function _update_position_and_scale (entity, dt)
    local parent_position = entity.parentId ~= 0
        and ink:getEntity(entity.parentId).rect_transform.position
        or {x = 0, y = 0}

    local parent_scale = entity.parentId ~= 0
        and ink:getEntity(entity.parentId).rect_transform.scale
        or {x = love.graphics.getWidth(), y = love.graphics.getHeight()}

    local origin_x = parent_position.x
    local origin_y = parent_position.y

    local width = parent_scale.x
    local height = parent_scale.y

    local final_pos_x = (width * (1 - entity.rect_transform.anchors.left))
                            + entity.rect_transform.offset.left + origin_x

    local final_pos_y = (height * (1 - entity.rect_transform.anchors.up))
                            + entity.rect_transform.offset.up + origin_y

    local final_scale_x = width * (1 - ((1 - entity.rect_transform.anchors.right)
                            + (1 - entity.rect_transform.anchors.left)))
                            - entity.rect_transform.offset.left
                            - entity.rect_transform.offset.right

    local final_scale_y = height * (1 - ((1 - entity.rect_transform.anchors.up)
                            + (1 - entity.rect_transform.anchors.down)))
                            - entity.rect_transform.offset.up
                            - entity.rect_transform.offset.down

    if entity.rect_transform.preserve_aspect_ratio then
        if final_scale_x < final_scale_y then
            final_pos_y = final_pos_y + final_scale_y / 2 - final_scale_x / 2
            final_scale_y = final_scale_x
        else
            final_pos_x = final_pos_x + final_scale_x / 2 - final_scale_y / 2
            final_scale_x = final_scale_y
        end
    end

    if entity.rect_transform.useTween then
        entity.rect_transform.position.x = lerp(entity.rect_transform.position.x,
                                                    final_pos_x,
                                                    entity.rect_transform.velocity * ink.velocity * dt)
        entity.rect_transform.position.y = lerp(entity.rect_transform.position.y,
                                                    final_pos_y,
                                                    entity.rect_transform.velocity * ink.velocity * dt)
        entity.rect_transform.scale.x = lerp(entity.rect_transform.scale.x,
                                                final_scale_x,
                                                entity.rect_transform.velocity * ink.velocity * dt)
        entity.rect_transform.scale.y = lerp(entity.rect_transform.scale.y,
                                                final_scale_y,
                                                entity.rect_transform.velocity * ink.velocity * dt)
    else
        entity.rect_transform.position.x = final_pos_x
        entity.rect_transform.position.y = final_pos_y
        entity.rect_transform.scale.x = final_scale_x
        entity.rect_transform.scale.y = final_scale_y
    end
end

function rect_transform.update (entity, dt)
    _update_position_and_scale(entity, dt)
end

-- example: button.rect_transform.move(hero_id, "offset", 20, 10)
function rect_transform.move (entity, property, deltaX, deltaY)
    entity.rect_transform[property].left  = entity.rect_transform[property].left - deltaX
    entity.rect_transform[property].right = entity.rect_transform[property].right + deltaX
    entity.rect_transform[property].up    = entity.rect_transform[property].up - deltaY
    entity.rect_transform[property].down  = entity.rect_transform[property].down + deltaY
end

function rect_transform.isMouseOver (entity_rect_transform)
    local mouse_x = love.mouse.getX()
    local mouse_y = love.mouse.getY()

    return mouse_x > entity_rect_transform.position.x
        and mouse_x < entity_rect_transform.position.x + entity_rect_transform.scale.x
        and mouse_y > entity_rect_transform.position.y
        and mouse_y < entity_rect_transform.position.y + entity_rect_transform.scale.y
end


return rect_transform
