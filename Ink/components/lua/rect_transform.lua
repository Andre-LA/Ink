local RectTransform = {}
RectTransform.__index = RectTransform

function RectTransform:new (ink, element, parameters)
    setmetatable(RectTransform, {__index = ink.COMPONENT})
    ink.COMPONENT.new(self, ink, element, 1, parameters.parentId)
    setmetatable(self, RectTransform)

    -- if 'parameters' is nil, then provide the default 'parameters'
    parameters.anchors = parameters.anchors or {up = 1, right = 1, down = 1, left = 1}
    parameters.offset  = parameters.offset  or {up = 0, right = 0, down = 0, left = 0}
    parameters.links   = parameters.links   or {up = true, right = true, down = true, left = true}

    -- anchors, is a 0-1 value, represent the percentage position of each side of the parent pannel
    self.anchors = {
        up = parameters.anchors.up,
        right = parameters.anchors.right,
        down = parameters.anchors.down,
        left = parameters.anchors.left,
    }

    -- offset of each side, is used when any side is linked
    self.offset = {
        up = parameters.offset.up,
        right = parameters.offset.right,
        down = parameters.offset.down,
        left = parameters.offset.left,
    }

    -- link type of each side, can be true or false, true means 'linked'
    self.links = {
        up = parameters.links.up,
        right = parameters.links.right,
        down = parameters.links.down,
        left = parameters.links.left,
    }

    -- position and scale, this will be useful for rendering components
    self.position = {
        x = 0,
        y = 0,
        z = parameters.posZ or 0,
    }
    self.scale = {
        x = 0,
        y = 0,
    }

    -- tween configurations
    self.useTween = parameters.useTween
    if self.useTween == nil then self.useTween = true end

    self.preserveAspectRatio = parameters.preserveAspectRatio
    if self.preserveAspectRatio == nil then self.preserveAspectRatio = false end

    self.velocity = parameters.velocity or 1
    return self
end

function RectTransform:update (dt)
    self:updatePositionAndScale(dt)
end

function RectTransform:updatePositionAndScale (dt)
    local parentPosition = self.parentId ~= 0 and self.ink:getElement(self.parentId).rect_transform.position or {x = 0, y = 0}
    local parentScale    = self.parentId ~= 0 and self.ink:getElement(self.parentId).rect_transform.scale    or {x = self.ink.width, y = self.ink.height}
    local parentOffset   = self.parentId ~= 0 and self.ink:getElement(self.parentId).rect_transform.offset   or {up = 0, right = 0, down = 0, left = 0}
    local parentAnchors  = self.parentId ~= 0 and self.ink:getElement(self.parentId).rect_transform.anchors  or {up = 1, right = 1, down = 1, left = 1}

    local originX = parentPosition.x
    local originY = parentPosition.y

    local width   = parentScale.x
    local height  = parentScale.y

    local finalPosX   = (width  * (1 - self.anchors.left)) + self.offset.left + originX
    local finalPosY   = (height * (1 - self.anchors.up))   + self.offset.up   + originY

    local finalScaleX = width  * (1 - ((1 - self.anchors.right) + (1 - self.anchors.left))) - self.offset.left - self.offset.right
    local finalScaleY = height * (1 - ((1 - self.anchors.up)    + (1 - self.anchors.down))) - self.offset.up   - self.offset.down

    if self.preserveAspectRatio then
        if finalScaleX < finalScaleY then
            finalPosY = finalPosY + finalScaleY/2 - finalScaleX/2
            finalScaleY = finalScaleX
        else
            finalPosX = finalPosX + finalScaleX/2 - finalScaleY/2
            finalScaleX = finalScaleY
        end
    end


    if self.useTween then
        self.position.x = self:lerp(self.position.x, finalPosX  , self.velocity * self.ink.velocity * dt)
        self.position.y = self:lerp(self.position.y, finalPosY  , self.velocity * self.ink.velocity * dt)
        self.scale.x    = self:lerp(self.scale.x   , finalScaleX, self.velocity * self.ink.velocity * dt)
        self.scale.y    = self:lerp(self.scale.y   , finalScaleY, self.velocity * self.ink.velocity * dt)
    else
        self.position.x = finalPosX
        self.position.y = finalPosY
        self.scale.x    = finalScaleX
        self.scale.y    = finalScaleY
    end
end

-- example: button.rectTransform:move("offset", 20, 10)
function RectTransform:move (propertie, deltaX, deltaY)
    self[propertie].left  = self[propertie].left + deltaX
    self[propertie].right = self[propertie].right + deltaX
    self[propertie].up    = self[propertie].up + deltaY
    self[propertie].down  = self[propertie].down + deltaY
end

function RectTransform:lerp (initial, final, interpolation)
     return initial + (final - initial) * interpolation
end

return RectTransform
