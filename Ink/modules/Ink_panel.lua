local Panel = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()

function Panel:start (values, inkLib, name)
    self.isResizable = true
    self.isTittleEditable = false
    self.useInterpolationWhileGrabbing = false
    self.lockHover = false
    self.color = {200, 20, 20, 255}

    Panel(values, inkLib, name)

    self.isOnResize = false
    self.isGrabbed = false
    self.isActive = false
    self.isRenamingTitle = false
end

function Panel:mousepressed (x, y, b)
    if self.inHover then
        -- set active
        self.isActive = true


         -- if is not resizing and the mouse is over tittle
        if y < self.pos.y + 20 and not self.isOnResize then
            -- if left click, enable grabbing
            if b == 1 then
                -- enable grabbing and disable title editing
                self.isGrabbed = true

                -- move the panel to the mouse position (considerating pivot)
                self:setPosition(
                    love.mouse.getX() - (self.size.x * self.pivot.x) - self.inkLib.instances[self.parent].pos.x,
                    love.mouse.getY() - (self.size.y * self.pivot.y) - self.inkLib.instances[self.parent].pos.y
                )

                -- if is not to use Ink interpolation when grabbing, disable the interpolation of the group
                if self.group ~= nil and not self.useInterpolationWhileGrabbing then
                    for i=1,#self.group do
                        self.group[i].posInterpolDisabled = true
                    end
                else
                    self.posInterpolDisabled = true
                end
            -- elseif right click, enable or disable renaming
            elseif b == 2 and self.isActive then
                self.isRenamingTitle = not self.isRenamingTitle
            end
        -- else if is not grabbing and the mouse is over the rezize icon
        elseif y > self.pos.y + self.size.y - 10 and x > self.pos.x + self.size.x - 10 and not self.isGrabbed then
            self.sizeInterpolDisabled = true
            self.isOnResize = true
        -- elseif is mouse over the panel area
        elseif y > self.pos.y + 20 and y < self.pos.y + self.size.y - 10 then
            self.isRenamingTitle = false
        end
    else
        self.isRenamingTitle = false
        self.isActive = false
    end
end

function Panel:mousereleased (x, y, b)
    if self.isGrabbed then
        -- fix the panel position on release
        self:setPosition(
            love.mouse.getX() + (self.size.x * self.pivot.x) - self.inkLib.instances[self.parent].pos.x,
            love.mouse.getY() + (self.size.y * self.pivot.y) - self.inkLib.instances[self.parent].pos.y
        )
        self.isGrabbed = false
    end
    self.isOnResize = false
    if self.group ~= nil and not self.useInterpolationWhileGrabbing then
        for i=1,#self.group do
            self.group[i].posInterpolDisabled = false
        end
    else
        self.posInterpolDisabled = false
    end
    self.sizeInterpolDisabled = false
end

function Panel:update ()
    -- grab control
    if self.isGrabbed then
        -- move the panel to the mouse position (considerating pivot)
        self:setPosition(
            love.mouse.getX() - (self.size.x * self.pivot.x) - self.inkLib.instances[self.parent].pos.x,
            love.mouse.getY() - (self.size.y * self.pivot.y) - self.inkLib.instances[self.parent].pos.y
        )
    end

    -- resize control
    if self.isOnResize then
        if self.size.x > 40 and self.size.y > 40 then
            self:setSize(math.abs(love.mouse.getX() - self.pos.x), math.abs(love.mouse.getY() - self.pos.y))
        elseif love.mouse.getX() > self.pos.x + self.size.x or love.mouse.getY() > self.pos.y + self.size.y then
            self:setSize(math.abs(love.mouse.getX() - self.pos.x), math.abs(love.mouse.getY() - self.pos.y))
        end
    end
end

function Panel:textinput (text)
    if self.isRenamingTitle then
        self.text = self.text .. text
    end
end

function Panel:keypressed (key)
    if self.isRenamingTitle then
        if key == "backspace" then
            -- [backspace code by love2d.org/wiki/utf8]
            -- get the byte offset to the last UTF-8 character in the string.
            local byteoffset = utf8.offset(self.text, -1)

            if byteoffset then
                -- remove the last UTF-8 character.
                -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
                self.text = string.sub(self.text, 1, byteoffset - 1)
            end
        end
    end
end

function Panel:draw (dt)
    -- window box
    love.graphics.setColor(100,100,100)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line", self.pos.x, self.pos.y + 21, self.size.x, self.size.y - 20)

    -- set the title color
    if not self.isGrabbed then
        if self.isRenamingTitle then
            self.color = {240, 150, 20, 255}
        elseif self.isActive then
            self.color = {220, 20, 20, 255}
        else
            self.color = {200, 20, 20, 255}
            love.graphics.setColor(200, 20, 20)
        end
    else
        self.color = {180, 40, 60, 255}
    end
    love.graphics.setColor(self.color)

    -- title box
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, 20)

    love.graphics.setColor(250, 20, 20)
    love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.x, 20)

    -- title text
    love.graphics.setColor(250, 250, 250)
    love.graphics.print(self.text, self.pos.x + 10, self.pos.y)



    -- the rezize icon
    local iniColor = 0
    if not self.isOnResize then
        iniColor = 250
    else
        iniColor = 200
    end

    -- draw the resize icon (its 4 boxes with 4 different colors)
    for i=1,4 do
        love.graphics.setColor(iniColor, iniColor, iniColor)
        love.graphics.rectangle("fill", self.pos.x + self.size.x - 10, self.pos.y + self.size.y - 10, 10 - (2 * (i-1)), 10 - (2 * (i-1)))
        iniColor = iniColor - 50
    end

end
return Panel
