local Group = {}
Group.__index = Group

function Group:new (ink, id, priority)
    setmetatable(self, Group)

    self.elements = {}

    self.ink = ink
    self.id = id
    self.priority = priority

    return self
end

function Group:createElement (name, id, parameters)
    local newEntity = self.ink.ELEMENT.new({}, self.ink, name, id, parameters or {})
    self.elements[#self.elements+1] = newEntity
end

local function orderElementsByPosZ (elements)
    local i = 1
    while i < #elements do
        if i ~= #elements then
            if elements[i].rect_transform.position.z < elements[i+1].rect_transform.position.z then
                elements[i+1], elements[i] = elements[i], elements[i+1]
                i = 0
            end
        end
        i=i+1
    end
end

function Group:update (dt)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:update (dt)
        i = i + 1
    end
end

function Group:lateupdate (dt)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:lateupdate (dt)
        i = i + 1
    end
end

function Group:draw ()
    orderElementsByPosZ(self.elements)

    local i = 1
    while i <= #self.elements do
        self.elements[i]:draw()
        i = i + 1
    end
end

function Group:keypressed (key, scancode, isrepeat)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:keypressed (key, scancode, isrepeat)
        i = i + 1
    end
end
function Group:keyreleased (key)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:keyreleased (key)
        i = i + 1
    end
end
function Group:directorydropped ()
    local i = 1
    while i <= #self.elements do
        self.elements[i]:directorydropped ()
        i = i + 1
    end
end
function Group:filedropped (file)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:filedropped (file)
        i = i + 1
    end
end
function Group:focus (focus)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:focus (focus)
        i = i + 1
    end
end
function Group:lowmemory ()
    local i = 1
    while i <= #self.elements do
        self.elements[i]:lowmemory ()
        i = i + 1
    end
end
function Group:mousefocus (focus)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:mousefocus (focus)
        i = i + 1
    end
end
function Group:mousemoved (x, y, dx, dy, istouch)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:mousemoved (x, y, dx, dy, istouch)
        i = i + 1
    end
end
function Group:mousepressed (x, y, button, istouch)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:mousepressed (x, y, button, istouch)
        i = i + 1
    end
end
function Group:mousereleased (x, y, button, istouch)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:mousereleased (x, y, button, istouch)
        i = i + 1
    end
end
function Group:quit ()
    local i = 1
    while i <= #self.elements do
        self.elements[i]:quit()
        i = i + 1
    end
end
function Group:touchmoved (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:touchmoved (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end
function Group:touchpressed (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:touchpressed (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end
function Group:touchreleased (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:touchreleased (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end
function Group:visible (visible)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:visible(visible)
        i = i + 1
    end
end
function Group:wheelmoved (x, y)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:wheelmoved (x, y)
        i = i + 1
    end
end
function Group:resize (w, h)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:resize(w, h)
        i = i + 1
    end
end
function Group:textinput (text)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:textinput (text)
        i = i + 1
    end
end
function Group:textedited (text, start, length)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:textedited (text, start, length)
        i = i + 1
    end
end
function Group:gamepadaxis (joystick, axis, value)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:gamepadaxis (joystick, axis, value)
        i = i + 1
    end
end
function Group:gamepadpressed (joystick, button)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:gamepadpressed (joystick, button)
        i = i + 1
    end
end
function Group:gamepadreleased (joystick, button)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:gamepadreleased (joystick, button)
        i = i + 1
    end
end
function Group:joystickadded (joystick)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:joystickadded (joystick)
        i = i + 1
    end
end
function Group:joystickaxis (joystick, axis, value)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:joystickaxis (joystick, axis, value)
        i = i + 1
    end
end
function Group:joystickhat (joystick, hat, direction)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:joystickhat (joystick, hat, direction)
        i = i + 1
    end
end
function Group:joystickpressed (joystick, button)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:joystickpressed (joystick, button)
        i = i + 1
    end
end
function Group:joystickreleased (joystick, button)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:joystickreleased (joystick, button)
        i = i + 1
    end
end
function Group:joystickremoved (joystick)
    local i = 1
    while i <= #self.elements do
        self.elements[i]:joystickremoved (joystick)
        i = i + 1
    end
end

return Group
