local DrawImage = {}
DrawImage.__index = DrawImage

function DrawImage:new (ink, element, parameters)
    setmetatable(DrawImage, {__index = ink.COMPONENT})
    ink.COMPONENT.new(self, ink, element, 50, parameters.parentId)
    setmetatable(self, DrawImage)

    if parameters.use9sliced then
        self.using9sliced = true
        self.images = {
            up     = parameters.imageUp,
            upright = parameters.imageUpRight,
            right  = parameters.imageRight,
            rightdown = parameters.imageRightDown,
            down   = parameters.imageDown,
            downleft = parameters.imageDownLeft,
            left   = parameters.imageLeft,
            leftup = parameters.imageLeftUp,
            center = parameters.imageCenter,
        }
    else
        self.using9sliced = false
        self.image = parameters.image
    end
    self.imageColor = parameters.imageColor or {255, 255, 255, 255}
    self.preserve = parameters.preserve or "nothing"
    return self
end

function DrawImage:draw ()
    love.graphics.setColor(self.imageColor)

    local posX = self.element.rect_transform.position.x
    local posY = self.element.rect_transform.position.y

    if not self.using9sliced then
        local scaleX = self.element.rect_transform.scale.x / self.image:getWidth()
        local scaleY = self.element.rect_transform.scale.y / self.image:getHeight()

        love.graphics.draw(self.image, posX, posY, 0, scaleX, scaleY)
    else
        -- corners
        local leftup_px_x    = self.images.leftup:getWidth()
        local upright_px_x   = self.images.upright:getWidth()
        local downleft_px_x  = self.images.downleft:getWidth()
        local rightdown_px_x = self.images.rightdown:getWidth()

        local leftup_px_y    = self.images.leftup:getHeight()
        local upright_px_y   = self.images.upright:getHeight()
        local downleft_px_y  = self.images.downleft:getHeight()
        local rightdown_px_y = self.images.rightdown:getHeight()

        -- static values
        local up_px_y    = self.images.up:getHeight()
        local left_px_x  = self.images.left:getWidth()
        local right_px_x = self.images.right:getWidth()
        local down_px_y  = self.images.down:getHeight()

        local up_px_x = self.element.rect_transform.scale.x - leftup_px_x - upright_px_x
        local ren_scaleUpX = up_px_x / self.images.up:getWidth()

        local left_px_y =  self.element.rect_transform.scale.y - leftup_px_y - downleft_px_y
        local ren_scaleLeftY = left_px_y / self.images.left:getHeight()

        local center_px_x = self.element.rect_transform.scale.x - left_px_x - right_px_x
        local center_px_y = self.element.rect_transform.scale.y - up_px_y - down_px_y
        local ren_scaleCenterX = center_px_x / self.images.center:getWidth()
        local ren_scaleCenterY = center_px_y / self.images.center:getHeight()

        local right_px_y = self.element.rect_transform.scale.y - upright_px_y - rightdown_px_y
        local ren_scaleRightY = right_px_y / self.images.right:getHeight()

        local down_px_x = self.element.rect_transform.scale.x - downleft_px_x - rightdown_px_x
        local ren_scaleDownX = down_px_x / self.images.down:getWidth()

        -- render
        -- top
        love.graphics.draw(self.images.leftup, posX, posY, 0, 1, 1)
        love.graphics.draw(self.images.up, posX + leftup_px_x, posY, 0, ren_scaleUpX, 1)
        love.graphics.draw(self.images.upright, posX + leftup_px_x + up_px_x, posY, 0, 1, 1)

        -- center
        love.graphics.draw(self.images.left, posX, posY + leftup_px_y, 0, 1, ren_scaleLeftY)
        love.graphics.draw(self.images.center, posX + left_px_x, posY + up_px_y, 0, ren_scaleCenterX, ren_scaleCenterY)
        love.graphics.draw(self.images.right, posX + left_px_x + center_px_x, posY + upright_px_y, 0, 1, ren_scaleRightY)

        -- bottom
        love.graphics.draw(self.images.downleft, posX, posY + leftup_px_y + left_px_y, 0, 1, 1)
        love.graphics.draw(self.images.down, posX + downleft_px_x, posY + up_px_y + center_px_y, 0, ren_scaleDownX, 1)
        love.graphics.draw(self.images.rightdown, posX + downleft_px_x + down_px_x, posY + upright_px_y + right_px_y, 0, 1, 1)
    end
end

return DrawImage
