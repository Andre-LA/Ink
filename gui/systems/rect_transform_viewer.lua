local rect_transform_viewer = {}
rect_transform_viewer.__index = rect_transform_viewer
local _ceil = math.ceil
local ink = {}

function rect_transform_viewer.new (_ink)
    local self = {
        entities = {},
        name = "rect_transform_viewer",
        requires = {"rect_transform_viewer", "rect_transform"},
    }
    ink = _ink
    setmetatable(self, rect_transform_viewer)
    return self
end

function rect_transform_viewer.draw (entity)
    if ink.devMode then
        love.graphics.setColor(entity.rect_transform_viewer.color)
        love.graphics.rectangle("line", entity.rect_transform.position.x, entity.rect_transform.position.y,
                                entity.rect_transform.scale.x, entity.rect_transform.scale.y)

        if entity.rect_transform_viewer.useText then
            love.graphics.print(entity.name,
                                _ceil(entity.rect_transform.position.x),
                                _ceil(entity.rect_transform.position.y))
        end
    end
end

return rect_transform_viewer
