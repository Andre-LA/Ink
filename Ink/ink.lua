local Ink = {}
Ink.__index = Ink

Ink.PATH = (...):match("(.-)[^%/%.]+$")
Ink.lastElementId = 0
Ink.lastGroupId = 0
Ink.GROUP = require (Ink.PATH .. "/group")
Ink.ELEMENT = require (Ink.PATH .. "/element")
Ink.COMPONENT = require(Ink.PATH .. "/component")
Ink.RECT_TRANSFORM = require (Ink.PATH .. "/components/lua/rect_transform")

function Ink.new (devMode, width, height)
    local self = setmetatable({}, Ink)

    self.devMode = devMode or false

    self.groups = {}
    self:createGroup(1)
    self.velocity = 1

    self.width = width
    self.height = height

    self.executionOrder = {
        rect_transform = 0,
        draw_image = 1,
        button = 1,
        text = 1,
        rect_transform_viewer = 1,
    }

    return self
end

function Ink:createElement (name, groupId, parameters)
    self.lastElementId = self.lastElementId + 1

    local group = self:getGroup(groupId)
    group:createElement(name, self.lastElementId, parameters)

    return self.lastElementId
end

-- get and return a element by id
function Ink:getElement (elementId)
    local done = false

    for i=1,#self.groups do
        for j=1,#self.groups[i].elements do
            if elementId == self.groups[i].elements[j].id then
                return self.groups[i].elements[j]
            end
        end
        if done then break end
    end
end

function Ink:createGroup (priority)
    self.lastGroupId = self.lastGroupId + 1
    local newGroup = self.GROUP.new({}, self, self.lastGroupId, priority)

    self.groups[#self.groups+1] = newGroup

    return self.lastGroupId
end

function Ink:getGroup (groupId)
    local ret = {}

    for i=1,#self.groups do
        if self.groups[i].id == groupId then
            ret = self.groups[i]
            break
        end
    end

    return ret
end

function Ink:update (dt)

    local i = 1
    while i <= #self.groups do
        self.groups[i]:update(dt)
        i = i + 1
    end

    i = 1
    while i <= #self.groups do
        self.groups[i]:lateupdate(dt)
        i = i + 1
    end
end

function Ink:draw ()
    love.graphics.push()
    love.graphics.origin()

    local i = 1
    while i <= #self.groups do
        self.groups[i]:draw()
        i = i + 1
    end

    love.graphics.pop()
end

function Ink:keypressed (key, scancode, isrepeat)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:keypressed (key, scancode, isrepeat)
        i = i + 1
    end
end
function Ink:keyreleased (key)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:keyreleased (key)
        i = i + 1
    end
end
function Ink:directorydropped ()
    local i = 1
    while i <= #self.groups do
        self.groups[i]:directorydropped ()
        i = i + 1
    end
end
function Ink:filedropped (file)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:filedropped (file)
        i = i + 1
    end
end
function Ink:focus (focus)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:focus (focus)
        i = i + 1
    end
end
function Ink:lowmemory ()
    local i = 1
    while i <= #self.groups do
        self.groups[i]:lowmemory ()
        i = i + 1
    end
end
function Ink:mousefocus (focus)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:mousefocus (focus)
        i = i + 1
    end
end
function Ink:mousemoved (x, y, dx, dy, istouch)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:mousemoved (x, y, dx, dy, istouch)
        i = i + 1
    end
end
function Ink:mousepressed (x, y, button, istouch)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:mousepressed (x, y, button, istouch)
        i = i + 1
    end
end
function Ink:mousereleased (x, y, button, istouch)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:mousereleased (x, y, button, istouch)
        i = i + 1
    end
end
function Ink:quit ()
    local i = 1
    while i <= #self.groups do
        self.groups[i]:quit()
        i = i + 1
    end
end
function Ink:touchmoved (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:touchmoved (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end
function Ink:touchpressed (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:touchpressed (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end
function Ink:touchreleased (id, x, y, dx, dy, pressure)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:touchreleased (id, x, y, dx, dy, pressure)
        i = i + 1
    end
end
function Ink:visible (visible)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:visible(visible)
        i = i + 1
    end
end
function Ink:wheelmoved (x, y)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:wheelmoved (x, y)
        i = i + 1
    end
end
function Ink:resize (w, h)
    self.width = w
    self.height = h

    local i = 1
    while i <= #self.groups do
        self.groups[i]:resize(w, h)
        i = i + 1
    end
end
function Ink:textinput (text)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:textinput (text)
        i = i + 1
    end
end
function Ink:textedited (text, start, length)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:textedited (text, start, length)
        i = i + 1
    end
end
function Ink:gamepadaxis (joystick, axis, value)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:gamepadaxis (joystick, axis, value)
        i = i + 1
    end
end
function Ink:gamepadpressed (joystick, button)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:gamepadpressed (joystick, button)
        i = i + 1
    end
end
function Ink:gamepadreleased (joystick, button)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:gamepadreleased (joystick, button)
        i = i + 1
    end
end
function Ink:joystickadded (joystick)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:joystickadded (joystick)
        i = i + 1
    end
end
function Ink:joystickaxis (joystick, axis, value)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:joystickaxis (joystick, axis, value)
        i = i + 1
    end
end
function Ink:joystickhat (joystick, hat, direction)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:joystickhat (joystick, hat, direction)
        i = i + 1
    end
end
function Ink:joystickpressed (joystick, button)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:joystickpressed (joystick, button)
        i = i + 1
    end
end
function Ink:joystickreleased (joystick, button)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:joystickreleased (joystick, button)
        i = i + 1
    end
end
function Ink:joystickremoved (joystick)
    local i = 1
    while i <= #self.groups do
        self.groups[i]:joystickremoved (joystick)
        i = i + 1
    end
end

return Ink
