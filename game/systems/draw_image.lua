local draw_image = {}
draw_image.__index = draw_image
local ink = {}

function draw_image.new (_ink)
    local self = {
        entities = {},
        name = 'draw_image',
        requires = {'transform', 'draw_image'}
    }
    ink = _ink
    setmetatable(self, draw_image)
    return self
end

function draw_image.draw (entity)
    local transform_sys = ink:getSystem('transform')
    local corner_position = transform_sys.get_corner_position(entity.transform,
                                                                entity.draw_image.image_source:getWidth(),
                                                                entity.draw_image.image_source:getHeight())
    love.graphics.draw(entity.draw_image.image_source,
                        corner_position.x,
                        corner_position.y,
                        entity.transform.rotation,
                        entity.transform.scale.x,
                        entity.transform.scale.y)
end

return draw_image
