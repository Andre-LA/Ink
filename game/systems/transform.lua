local transform = {}
transform.__index = transform
local ink = {}
local atan2 = math.atan2
local sqrt  = math.sqrt
local cos   = math.cos
local sin   = math.sin

function transform.new (_ink)
    local self = {
        entities = {},
        name = 'transform',
        requires = {'transform'}
    }
    ink = _ink
    setmetatable(self, transform)
    return self
end

local function _update_transform_by_parent (entity)
    local parent_position = entity.parentId ~= 0
                                and ink:getEntity(entity.parentId).transform.position
                                or {x = 0, y = 0}

    local parent_rotation = entity.parentId ~= 0
                                and ink:getEntity(entity.parentId).transform.rotation
                                or 0

    local parent_scale = entity.parentId ~= 0
                                and ink:getEntity(entity.parentId).transform.scale
                                or {x = 1, y = 1}

    entity.transform.position.x = entity.transform.position.x + parent_position.x
    entity.transform.position.y = entity.transform.position.y + parent_position.y

    entity.transform.rotation = entity.transform.rotation + parent_rotation

    entity.transform.scale.x = entity.transform.scale.x * parent_scale.x
    entity.transform.scale.y = entity.transform.scale.y * parent_scale.y
end

function transform.get_corner_position (entity_transform, scale_x_in_pixels, scale_y_in_pixels)
    local corner_position = {
        x = entity_transform.position.x - scale_x_in_pixels * entity_transform.scale.x * entity_transform.pivot.x,
        y = entity_transform.position.y - scale_y_in_pixels * entity_transform.scale.y * entity_transform.pivot.y
    }

    local finalAngle = atan2(corner_position.y - entity_transform.position.y,
                                corner_position.x - entity_transform.position.x
                            ) + entity_transform.rotation

    local magnitude = sqrt((corner_position.x - entity_transform.position.x)
                                * (corner_position.x - entity_transform.position.x)
                                + (corner_position.y - entity_transform.position.y)
                                * (corner_position.y - entity_transform.position.y))

    local vector = {
        x = cos(finalAngle) * magnitude,
        y = sin(finalAngle) * magnitude
    }

    corner_position.x = entity_transform.position.x + vector.x
    corner_position.y = entity_transform.position.y + vector.y

    return corner_position
end

function transform.update (entity)
    _update_transform_by_parent(entity)
end

return transform
