local draw_image = {}
draw_image.__index = draw_image

function draw_image.new ()
    local self = {
        name = "draw_image",
        entities = {},
    }
    setmetatable(self, draw_image)
    return self
end

function draw_image.applyParameters (parameters)
    local finalParameters = {
        useSliced = parameters.useSliced or false,
        imageColor = parameters.imageColor or {255,255,255,255},
    }
    if parameters.useSliced then
        assert(parameters.images.up, "draw_image component: parameters.images.up is nil or false")
        assert(parameters.images.left, "draw_image component: parameters.images.left is nil or false")
        assert(parameters.images.right, "draw_image component: parameters.images.right is nil or false")
        assert(parameters.images.down, "draw_image component: parameters.images.down is nil or false")
        assert(parameters.images.leftup, "draw_image component: parameters.images.leftup is nil or false")
        assert(parameters.images.upright, "draw_image component: parameters.images.upright is nil or false")
        assert(parameters.images.downleft, "draw_image component: parameters.images.downleft is nil or false")
        assert(parameters.images.rightdown, "draw_image component: parameters.images.rightdown is nil or false")
        assert(parameters.images.center, "draw_image component: parameters.images.center is nil or false")

        finalParameters.images = parameters.images
    else
        assert(parameters.image, "draw_image component: parameters.image is nil or false")
        finalParameters.image = parameters.image
    end
    return finalParameters
end

function draw_image.draw (ink, entity)
    -- TODO tirar essas abreviações (ex: entity_draw_image)
    local entity_draw_image = entity.draw_image
    local entity_rect_transform = entity.rect_transform

    love.graphics.setColor(entity_draw_image.imageColor)

    local posX = entity_rect_transform.position.x
    local posY = entity_rect_transform.position.y

    if not entity_draw_image.useSliced then
        local scaleX = entity_rect_transform.scale.x / entity_draw_image.image:getWidth()
        local scaleY = entity_rect_transform.scale.y / entity_draw_image.image:getHeight()

        love.graphics.draw(entity_draw_image.image, posX, posY, 0, scaleX, scaleY)
    else
        -- corners
        local leftup_px_x    = entity_draw_image.images.leftup:getWidth()
        local upright_px_x   = entity_draw_image.images.upright:getWidth()
        local downleft_px_x  = entity_draw_image.images.downleft:getWidth()
        local rightdown_px_x = entity_draw_image.images.rightdown:getWidth()

        local leftup_px_y    = entity_draw_image.images.leftup:getHeight()
        local upright_px_y   = entity_draw_image.images.upright:getHeight()
        local downleft_px_y  = entity_draw_image.images.downleft:getHeight()
        local rightdown_px_y = entity_draw_image.images.rightdown:getHeight()

        -- static values
        local up_px_y    = entity_draw_image.images.up:getHeight()
        local left_px_x  = entity_draw_image.images.left:getWidth()
        local right_px_x = entity_draw_image.images.right:getWidth()
        local down_px_y  = entity_draw_image.images.down:getHeight()

        local up_px_x = entity_rect_transform.scale.x - leftup_px_x - upright_px_x
        local ren_scaleUpX = up_px_x / entity_draw_image.images.up:getWidth()

        local left_px_y =  entity_rect_transform.scale.y - leftup_px_y - downleft_px_y
        local ren_scaleLeftY = left_px_y / entity_draw_image.images.left:getHeight()

        local center_px_x = entity_rect_transform.scale.x - left_px_x - right_px_x
        local center_px_y = entity_rect_transform.scale.y - up_px_y - down_px_y
        local ren_scaleCenterX = center_px_x / entity_draw_image.images.center:getWidth()
        local ren_scaleCenterY = center_px_y / entity_draw_image.images.center:getHeight()

        local right_px_y = entity_rect_transform.scale.y - upright_px_y - rightdown_px_y
        local ren_scaleRightY = right_px_y / entity_draw_image.images.right:getHeight()

        local down_px_x = entity_rect_transform.scale.x - downleft_px_x - rightdown_px_x
        local ren_scaleDownX = down_px_x / entity_draw_image.images.down:getWidth()

        -- render
        -- top
        love.graphics.draw(entity_draw_image.images.leftup, posX, posY, 0, 1, 1)
        love.graphics.draw(entity_draw_image.images.up, posX + leftup_px_x, posY, 0, ren_scaleUpX, 1)
        love.graphics.draw(entity_draw_image.images.upright, posX + leftup_px_x + up_px_x, posY, 0, 1, 1)

        -- center
        love.graphics.draw(entity_draw_image.images.left, posX, posY + leftup_px_y, 0, 1, ren_scaleLeftY)
        love.graphics.draw(entity_draw_image.images.center, posX + left_px_x, posY + up_px_y, 0, ren_scaleCenterX, ren_scaleCenterY)
        love.graphics.draw(entity_draw_image.images.right, posX + left_px_x + center_px_x, posY + upright_px_y, 0, 1, ren_scaleRightY)

        -- bottom
        love.graphics.draw(entity_draw_image.images.downleft, posX, posY + leftup_px_y + left_px_y, 0, 1, 1)
        love.graphics.draw(entity_draw_image.images.down, posX + downleft_px_x, posY + up_px_y + center_px_y, 0, ren_scaleDownX, 1)
        love.graphics.draw(entity_draw_image.images.rightdown, posX + downleft_px_x + down_px_x, posY + upright_px_y + right_px_y, 0, 1, 1)
    end
end

return draw_image
