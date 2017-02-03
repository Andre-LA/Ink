local Panel = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()

function Panel:start (values, inkLib, name)
    self.isGrabbed = false
    self.isResizable = true
    self.isOnResize = false
    Panel(values, inkLib, name)
    self.lockHover = false
    self.pivotBkup = {x = self.pivot.x, y = self.pivot.y}
end

function Panel:mousepressed (x, y, b)
    -- grab control
    print("logging")
    if self.inHover and y < self.pos.y + 20 and b == 1 and not self.isOnResize then
        self.pivotBkup = {x = self.pivot.x, y = self.pivot.y}
        self.isGrabbed = true
        self.pivot = {x = 0, y = 0}

        if self.group ~= nil then
            for i=1,#self.group do
                self.group[i].posInterpolDisabled = true
            end
        else
            self.posInterpolDisabled = true
        end
    end

    if self.inHover and y > self.pos.y + self.size.y - 10 and x > self.pos.x + self.size.x - 10 and b == 1  and not self.isGrabbed then
        self.sizeInterpolDisabled = true
        self.isOnResize = true
    end
end

function Panel:mousereleased (x, y, b)
    self.isGrabbed = false
    print(self.pivotBkup.x, self.pivotBkup.y)

    --self.pivot = {x = self.pivotBkup.x, y = self.pivotBkup.y}
    self.isOnResize = false
    if self.group ~= nil then
        for i=1,#self.group do
            self.group[i].posInterpolDisabled = false
        end

    else
        self.posInterpolDisabled = false
    end
    self.sizeInterpolDisabled = false
end

function Panel:update ()
    if self.isGrabbed then
        self:setPosition(love.mouse.getX() - (self.size.x * self.pivot.x), love.mouse.getY() - (self.size.y * self.pivot.y))
    end

    if self.isOnResize then
        if self.size.x > 40 and self.size.y > 40 then
            self:setSize(math.abs(love.mouse.getX() - self.pos.x), math.abs(love.mouse.getY() - self.pos.y))
        elseif love.mouse.getX() > self.pos.x + self.size.x or love.mouse.getY() > self.pos.y + self.size.y then
            self:setSize(math.abs(love.mouse.getX() - self.pos.x), math.abs(love.mouse.getY() - self.pos.y))
        end
    end
end

function Panel:draw (dt)

    -- window
    love.graphics.setColor(100,100,100)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line", self.pos.x, self.pos.y + 21, self.size.x, self.size.y - 20)

    -- title
    if not self.isGrabbed then
        love.graphics.setColor(200, 20, 20)
    else
        love.graphics.setColor(180, 40, 40)
    end
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, 20)

    love.graphics.setColor(250, 20, 20)
    love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.x, 20)

    love.graphics.setColor(250, 250, 250)
    love.graphics.print(self.text, self.pos.x + 10, self.pos.y)



    -- the rezize icon
    local iniColor = 0
    if not self.isOnResize then
        iniColor = 250
    else
        iniColor = 200
    end

    for i=1,4 do
        love.graphics.setColor(iniColor, iniColor, iniColor)
        love.graphics.rectangle("fill", self.pos.x + self.size.x - 10, self.pos.y + self.size.y - 10, 10 - (2 * (i-1)), 10 - (2 * (i-1)))
        iniColor = iniColor - 50
    end

end
return Panel
