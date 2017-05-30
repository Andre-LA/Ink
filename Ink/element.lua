local Element = {}
Element.__index = Element

function Element:new (ink, name, id, parameters)
    setmetatable(self, Element)

    self.id = id
    self.name = name or "element#" .. self.id
    self.ink = ink
    self.components = {}
    self:addComponent(ink.PATH .. "/components/lua/rect_transform", parameters)

    return self
end

function Element:addComponent (url, parameters)
    local component = require (url).new({}, self.ink, self, parameters)

    if #self.components >= 1 then
        for i=1,#self.components do
            if self.components[i].priority > component.priority then
                table.insert(self.components, i, component);
            elseif i == #self.components then
                self.components[#self.components+1] = component
            end
        end
    else
        self.components[1] = component
    end
    
    -- remove paths of the name if exists ("/path/to/script" -> "script")
    while string.find(url, "/") do
        url = string.sub(url, string.find(url, "/") + 1)
    end

    self[url] = self.components[#self.components]
end

function Element:getState ()
    local ret = "none"

    -- is the mouse inside of element?
    if  love.mouse.getX() > self.rect_transform.position.x and love.mouse.getX() < self.rect_transform.position.x + self.rect_transform.scale.x
    and love.mouse.getY() > self.rect_transform.position.y and love.mouse.getY() < self.rect_transform.position.y + self.rect_transform.scale.y then
        if love.mouse.isDown(0) then
            ret = "onClick"
        else
            ret = "onHover"
        end
    end

    return ret
end

function Element:update (dt)
    local i = 1
    while i <= #self.components do
        local state = self:getState()
        self.components[i][state](self.components[i])

        self.components[i]:update(dt)
        i = i + 1
    end
end

function Element:lateupdate (dt)
    local i = 1
    while i <= #self.components do
        self.components[i]:lateupdate(dt)
        i = i + 1
    end
end

function Element:draw ()
    local i = 1
    while i <= #self.components do
        self.components[i]:draw()
        love.graphics.setColor(255, 255, 255, 255) -- reset color for the next component
        i = i + 1
    end
end

function Element:load()
    local i = 1
    while i <= #self.components do
        self.components[i]:load()
        i = i + 1
    end
end

function Element:keypressed (key, scancode, isrepeat)
    local i = 1
    while i <= #self.components do
        self.components[i]:keypressed (key, scancode, isrepeat)
        i = i + 1
    end
end

function Element:keyreleased (key)
    local i = 1
    while i <= #self.components do
        self.components[i]:keyreleased (key)
        i = i + 1
    end
end

function Element:directorydropped ()
    local i = 1
    while i <= #self.components do
        self.components[i]:directorydropped ()
        i = i + 1
    end
end

function Element:filedropped (file)
    local i = 1
    while i <= #self.components do
        self.components[i]:filedropped (file)
        i = i + 1
    end
end

function Element:focus (focus)
    local i = 1
    while i <= #self.components do
        self.components[i]:focus (focus)
        i = i + 1
    end
end

function Element:lowmemory ()
    local i = 1
    while i <= #self.components do
        self.components[i]:lowmemory ()
        i = i + 1
    end
end

function Element:mousefocus (focus)
    local i = 1
    while i <= #self.components do
        self.components[i]:mousefocus (focus)
        i = i + 1
    end
end

function Element:mousemoved (x, y, dx, dy, istouch)
    local i = 1
    while i <= #self.components do
        self.components[i]:mousemoved (x, y, dx, dy, istouch)
        i = i + 1
    end
end

function Element:mousepressed (x, y, button, istouch)
    local i = 1
    while i <= #self.components do
        self.components[i]:mousepressed (x, y, button, istouch)
        i = i + 1
    end
end

function Element:mousereleased (x, y, button, istouch)
    local i = 1
    while i <= #self.components do
        self.components[i]:mousereleased (x, y, button, istouch)
        i = i + 1
    end
end

function Element:quit()
    local i = 1
    while i <= #self.components do
        self.components[i]:quit()
        i = i + 1
    end
end

function Element:touchmoved (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.components do
        self.components[i]:touchmoved (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end

function Element:touchpressed (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.components do
        self.components[i]:touchpressed (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end

function Element:touchreleased (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.components do
        self.components[i]:touchreleased (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end

function Element:visible(visible)
    local i = 1
    while i <= #self.components do
        self.components[i]:visible(visible)
        i = i + 1
    end
end

function Element:wheelmoved (x, y)
    local i = 1
    while i <= #self.components do
        self.components[i]:wheelmoved (x, y)
        i = i + 1
    end
end

function Element:resize(w, h)
    local i = 1
    while i <= #self.components do
        self.components[i]:resize(w, h)
        i = i + 1
    end
end

function Element:textinput (text)
    local i = 1
    while i <= #self.components do
        self.components[i]:textinput (text)
        i = i + 1
    end
end

function Element:textedited (text, start, length)
    local i = 1
    while i <= #self.components do
        self.components[i]:textedited (text, start, length)
        i = i + 1
    end
end

function Element:gamepadaxis (joystick, axis, value)
    local i = 1
    while i <= #self.components do
        self.components[i]:gamepadaxis (joystick, axis, value)
        i = i + 1
    end
end

function Element:gamepadpressed (joystick, button)
    local i = 1
    while i <= #self.components do
        self.components[i]:gamepadpressed (joystick, button)
        i = i + 1
    end
end

function Element:gamepadreleased (joystick, button)
    local i = 1
    while i <= #self.components do
        self.components[i]:gamepadreleased (joystick, button)
        i = i + 1
    end
end

function Element:joystickadded (joystick)
    local i = 1
    while i <= #self.components do
        self.components[i]:joystickadded (joystick)
        i = i + 1
    end
end

function Element:joystickaxis (joystick, axis, value)
    local i = 1
    while i <= #self.components do
        self.components[i]:joystickaxis (joystick, axis, value)
        i = i + 1
    end
end

function Element:joystickhat (joystick, hat, direction)
    local i = 1
    while i <= #self.components do
        self.components[i]:joystickhat (joystick, hat, direction)
        i = i + 1
    end
end

function Element:joystickpressed (joystick, button)
    local i = 1
    while i <= #self.components do
        self.components[i]:joystickpressed (joystick, button)
        i = i + 1
    end
end

function Element:joystickreleased (joystick, button)
    local i = 1
    while i <= #self.components do
        self.components[i]:joystickreleased (joystick, button)
        i = i + 1
    end
end

function Element:joystickremoved (joystick)
    local i = 1
    while i <= #self.components do
        self.components[i]:joystickremoved (joystick)
        i = i + 1
    end
end


return Element
