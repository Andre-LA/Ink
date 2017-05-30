local Component = {}
Component.__index = Component

function Component:new (ink, element, priority, parentId)
    setmetatable(self, Component)

    self.ink = ink
    self.element = element
    self.priority = priority
    self.parentId = parentId or 0

    return self
end

function Component:load() end
function Component:update (dt) end
function Component:lateupdate (dt) end
function Component:draw () end
function Component:keypressed (key, scancode, isrepeat) end
function Component:keyreleased (key) end
function Component:directorydropped () end
function Component:filedropped (file) end
function Component:focus (focus) end
function Component:lowmemory () end
function Component:mousefocus (focus) end
function Component:mousemoved (x, y, dx, dy, istouch) end
function Component:mousepressed (x, y, button, istouch) end
function Component:mousereleased (x, y, button, istouch) end
function Component:quit() end
function Component:touchmoved (id, x, y, dx, dy, pressure) end
function Component:touchpressed (id, x, y, dx, dy, pressure) end
function Component:touchreleased (id, x, y, dx, dy, pressure) end
function Component:visible(visible) end
function Component:wheelmoved (x, y) end
function Component:resize(w, h) end
function Component:textinput (text) end
function Component:textedited (text, start, length) end
function Component:gamepadaxis (joystick, axis, value) end
function Component:gamepadpressed (joystick, button) end
function Component:gamepadreleased (joystick, button) end
function Component:joystickadded (joystick) end
function Component:joystickaxis (joystick, axis, value) end
function Component:joystickhat (joystick, hat, direction) end
function Component:joystickpressed (joystick, button) end
function Component:joystickreleased (joystick, button) end
function Component:joystickremoved (joystick) end

function Component:onClick() end
function Component:onHover() end
function Component:none () end

return Component
