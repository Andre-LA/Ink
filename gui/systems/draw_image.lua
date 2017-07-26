local draw_image = {}
draw_image.__index = draw_image

function draw_image.new ()
    local self = {
        name = "draw_image",
        entities = {},
        requires = {"draw_image", "rect_transform"}
    }
    setmetatable(self, draw_image)
    return self
end

function draw_image.draw (entity)
    love.graphics.setColor(entity.draw_image.imageColor)

    local pos_x = entity.rect_transform.position.x
    local pos_y = entity.rect_transform.position.y

    if not entity.draw_image.useSliced then
        local scale_x = entity.rect_transform.scale.x / entity.draw_image.image:getWidth()
        local scale_y = entity.rect_transform.scale.y / entity.draw_image.image:getHeight()

        love.graphics.draw(entity.draw_image.image, pos_x, pos_y, 0, scale_x, scale_y)
    else
        -- corners
        local leftup_px_x    = entity.draw_image.images.leftup:getWidth()
        local upright_px_x   = entity.draw_image.images.upright:getWidth()
        local downleft_px_x  = entity.draw_image.images.downleft:getWidth()
        local rightdown_px_x = entity.draw_image.images.rightdown:getWidth()

        local leftup_px_y    = entity.draw_image.images.leftup:getHeight()
        local upright_px_y   = entity.draw_image.images.upright:getHeight()
        local downleft_px_y  = entity.draw_image.images.downleft:getHeight()
        local rightdown_px_y = entity.draw_image.images.rightdown:getHeight()

        local up_px_y    = entity.draw_image.images.up:getHeight()
        local left_px_x  = entity.draw_image.images.left:getWidth()
        local right_px_x = entity.draw_image.images.right:getWidth()
        local down_px_y  = entity.draw_image.images.down:getHeight()

        local up_px_x = entity.rect_transform.scale.x - leftup_px_x - upright_px_x
        local ren_scaleUpX = up_px_x / entity.draw_image.images.up:getWidth()

        local left_px_y =  entity.rect_transform.scale.y - leftup_px_y - downleft_px_y
        local ren_scaleLeftY = left_px_y / entity.draw_image.images.left:getHeight()

        local center_px_x = entity.rect_transform.scale.x - left_px_x - right_px_x
        local center_px_y = entity.rect_transform.scale.y - up_px_y - down_px_y
        local ren_scaleCenterX = center_px_x / entity.draw_image.images.center:getWidth()
        local ren_scaleCenterY = center_px_y / entity.draw_image.images.center:getHeight()

        local right_px_y = entity.rect_transform.scale.y - upright_px_y - rightdown_px_y
        local ren_scaleRightY = right_px_y / entity.draw_image.images.right:getHeight()

        local down_px_x = entity.rect_transform.scale.x - downleft_px_x - rightdown_px_x
        local ren_scaleDownX = down_px_x / entity.draw_image.images.down:getWidth()

        -- render
        -- TOP
        love.graphics.draw(entity.draw_image.images.leftup,
                            pos_x,
                            pos_y,
                            0,
                            1,
                            1)
        love.graphics.draw(entity.draw_image.images.up,
                            pos_x + leftup_px_x,
                            pos_y,
                            0,
                            ren_scaleUpX,
                            1)
        love.graphics.draw(entity.draw_image.images.upright,
                            pos_x + leftup_px_x + up_px_x,
                            pos_y,
                            0,
                            1,
                            1)

        -- CENTER
        love.graphics.draw(entity.draw_image.images.left,
                            pos_x,
                            pos_y + leftup_px_y,
                            0,
                            1,
                            ren_scaleLeftY)
        love.graphics.draw(entity.draw_image.images.center,
                            pos_x + left_px_x,
                            pos_y + up_px_y,
                            0,
                            ren_scaleCenterX,
                            ren_scaleCenterY)
        love.graphics.draw(entity.draw_image.images.right,
                            pos_x + left_px_x + center_px_x,
                            pos_y + upright_px_y,
                            0,
                            1,
                            ren_scaleRightY)

        -- BOTTOM
        love.graphics.draw(entity.draw_image.images.downleft,
                            pos_x,
                            pos_y + leftup_px_y + left_px_y,
                            0,
                            1,
                            1)
        love.graphics.draw(entity.draw_image.images.down,
                            pos_x + downleft_px_x,
                            pos_y + up_px_y + center_px_y,
                            0,
                            ren_scaleDownX,
                            1)
        love.graphics.draw(entity.draw_image.images.rightdown,
                            pos_x + downleft_px_x + down_px_x,
                            pos_y + upright_px_y + right_px_y,
                            0,
                            1,
                            1)
    end
end

return draw_image
