local rect_transform_viewer = {}
rect_transform_viewer.__index = rect_transform_viewer

function rect_transform_viewer.new ()
    local self = {
        entities = {},
        name = "rect_transform_viewer",
    }
    setmetatable(self, rect_transform_viewer)
    return self
end

function rect_transform_viewer.applyParameters (parameters)
    local finalParameters = {
        useText = parameters.useText or true,
    }
    return finalParameters
end

function rect_transform_viewer.draw (ink, entity)
    local entity_rect_transform_viewer = entity.rect_transform_viewer
    local entity_rect_transform_vi = entity.rect_transform

    love.graphics.setColor(0, 255, 0, 255)
    if ink.devMode then
        love.graphics.rectangle("line", entity_rect_transform_vi.position.x, entity_rect_transform_vi.position.y,
                                entity_rect_transform_vi.scale.x, entity_rect_transform_vi.scale.y)

        if entity_rect_transform_viewer.useText then
            love.graphics.print(entity.name, entity_rect_transform_vi.position.x, entity_rect_transform_vi.position.y)
        end
    end
end

return rect_transform_viewer
