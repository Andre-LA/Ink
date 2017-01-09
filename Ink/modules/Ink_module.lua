-- Create modules using this as reference
local Module = {}

setmetatable(Module, {
    __call = function  (cls, ...)
        return cls:New(...)
    end
})

function Module:New (values, inkLib, name)
    -- Default properties:
    self.parent    = "Ink_origin"
    self.parentPos = {x = 0, y = 0}
    self.pos       = {x = 0, y = 0}
    self.size      = {x = 0, y = 0}
    self.isVisible = true
    self.geometry  = "rectangle"
    self.inHover   = false

    -- Variable properties:
    self.name = name
    self.value = values.value
    self.localPos = {x = values.position[1], y = values.position[2]}
    self.localSize = {x = values.size[1], y = values.size[2]}
    self.inkLib = inkLib

    -- Create extra or replace properties:
    for k,v in pairs(values) do
        if k ~= "position" and k ~= "size" and k ~= "name" and k ~= "value" then
            self[k] = v
        end
    end
end

function Module:getGlobalPosition ()
    return self.pos.x, self.pos.y
end

function Module:getLocalPosition ()
    return self.localPos.x, self.localPos.y
end

function Module:setPosition (x, y)
    self.localPos.x = x
    self.localPos.y = y
end

function Module:translate (x, y)
    self.localPos.x = self.localPos.x + x
    self.localPos.y = self.localPos.y + y
end

function Module:getGlobalSize ()
    return self.size.x, self.size.y
end

function Module:getLocalSize ()
    return self.localSize.x, self.localSize.y
end

function Module:setSize (x, y)
    self.localSize.x = x
    self.localSize.y = y
end

function Module:resize (x, y)
    self.localSize.x = self.localSize.x + x
    self.localSize.y = self.localSize.y + y
end

function Module:setParent (name)
    self.parent = name;
end

function Module:hover () end
function Module:nothover () end
function Module:mousedown (x, y, b) end

function Module:update (dt) end
function Module:draw () end
function Module:mousepressed (x, y, button, istouch) end
function Module:mousereleased (x, y, button, istouch) end
function Module:keypressed (key, scancode, isrepeat) end
function Module:keyreleased (key) end
function Module:directorydropped () end
function Module:filedropped (file) end
function Module:focus (focus) end
function Module:lowmemory () end
function Module:mousefocus (focus) end
function Module:mousemoved (x, y, dx, dy, istouch) end
function Module:mousepressed (x, y, button, istouch) end
function Module:mousereleased (x, y, button, istouch) end
function Module:quit() end
function Module:touchmoved (id, x, y, dx, dy, pressure) end
function Module:touchpressed (id, x, y, dx, dy, pressure) end
function Module:touchreleased (id, x, y, dx, dy, pressure) end
function Module:visible(visible) end
function Module:wheelmoved (x, y) end
function Module:resize(w, h) end
function Module:textinput (text) end
function Module:textedited (text, start, length) end
function Module:gamepadaxis (joystick, axis, value) end
function Module:gamepadpressed (joystick, button) end
function Module:gamepadreleased (joystick, button) end
function Module:joystickadded (joystick) end
function Module:joystickaxis (joystick, axis, value) end
function Module:joystickhat (joystick, hat, direction) end
function Module:joystickpressed (joystick, button) end
function Module:joystickreleased (joystick, button) end
function Module:joystickremoved (joystick) end

function Module:getValue ()
    return self.value
end

function Module:setValue (newValue)
    self.value = newValue
end

return Module
