ink = require "Ink/Ink"
-- arquivo exemplo (example file)
function love.load()
    cont = 0
end
function love.update(dt)
    ink:update(dt)
end
function love.draw()
    ink:draw()
end
function love.mousepressed(x, y, button, isTouch)
    ink:mousepressed(x, y, button, isTouch)
end
function love.mousereleased (x, y, button, istouch)
    ink:mousereleased (x, y, button, istouch)
end
function love.keypressed(key, scancode, isrepeat)
    ink:keypressed(key, scancode, isrepeat)
end
function love.keyreleased (key)
    ink:keyreleased (key)
end
function love.directorydropped ()
    ink:directorydropped ()
end
function love.filedropped (file)
    ink:filedropped (file)
end
function love.focus (focus)
    ink:focus (focus)
end
function love.lowmemory ()
    ink:lowmemory ()
end
function love.mousefocus (focus)
    ink:mousefocus (focus)
end
function love.mousemoved (x, y, dx, dy, istouch)
    ink:mousemoved (x, y, dx, dy, istouch)
end
function love.mousereleased (x, y, button, istouch)
    ink:mousereleased (x, y, button, istouch)
end
function love.quit()
    ink:quit()
end
function love.touchmoved (id, x, y, dx, dy, pressure)
    ink:touchmoved (id, x, y, dx, dy, pressure)
end
function love.touchpressed (id, x, y, dx, dy, pressure)
    ink:touchpressed (id, x, y, dx, dy, pressure)
end
function love.touchreleased (id, x, y, dx, dy, pressure)
    ink:touchreleased (id, x, y, dx, dy, pressure)
end
function love.visible(visible)
    ink:visible(visible)
end
function love.wheelmoved (x, y)
    ink:wheelmoved (x, y)
end
function love.resize(w, h)
    ink:resize(w, h)
end
function love.textinput (text)
    ink:textinput (text)
end
function love.textedited (text, start, length)
    ink:textedited (text, start, length)
end
function love.gamepadaxis (joystick, axis, value)
    ink:gamepadaxis (joystick, axis, value)
end
function love.gamepadpressed (joystick, button)
    ink:gamepadpressed (joystick, button)
end
function love.gamepadreleased (joystick, button)
    ink:gamepadreleased (joystick, button)
end
function love.joystickadded (joystick)
    ink:joystickadded (joystick)
end
function love.joystickaxis (joystick, axis, value)
    ink:joystickaxis (joystick, axis, value)
end
function love.joystickhat (joystick, hat, direction)
    ink:joystickhat (joystick, hat, direction)
end
function love.joystickpressed (joystick, button)
    ink:joystickpressed (joystick, button)
end
function love.joystickreleased (joystick, button)
    ink:joystickreleased (joystick, button)
end
function love.joystickremoved (joystick)
    ink:joystickremoved (joystick)
end
