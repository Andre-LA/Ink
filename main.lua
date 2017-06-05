-- arquivo de demonstração (demo file)

local Ink = require "Ink/ink"
local ink = Ink.new(true, love.graphics.getWidth(), love.graphics.getHeight())

function love.load(args)
    local texto_id = ink:createElement("texto", 1, {
        anchors = {left=0.6, up=0.6, right=0.6, down=0.6}
    })
    local texto_el = ink:getElement(texto_id)
    texto_el:addComponent("Ink/components/love/draw_image", {
        use9sliced = true,
        imageLeftUp = love.graphics.newImage("image_test/9sliced/up_left.png"),
        imageUp = love.graphics.newImage("image_test/9sliced/up.png"),
        imageUpRight = love.graphics.newImage("image_test/9sliced/up_right.png"),

        imageLeft = love.graphics.newImage("image_test/9sliced/left.png"),
        imageCenter = love.graphics.newImage("image_test/9sliced/center.png"),
        imageRight = love.graphics.newImage("image_test/9sliced/right.png"),

        imageDownLeft = love.graphics.newImage("image_test/9sliced/left_down.png"),
        imageDown = love.graphics.newImage("image_test/9sliced/down.png"),
        imageRightDown = love.graphics.newImage("image_test/9sliced/down_right.png"),

        imageColor = {197,134,165,255}
    })
    texto_el:addComponent("Ink/components/love/text", {
        text = {{200,0,0,255},"Löv",
                {200,200,0,255}, "e ",
                {0,200,0,255},"Text"},
        horizontalAlign = "center",
        verticalAlign = "center",
    })
    texto_el:addComponent("Ink/components/love/rect_transform_viewer", {})
end

function love.update (dt)
    love.window.setTitle("Ink Demo: Q/S (fps): [" .. love.timer.getFPS() .. "]")
    ink:update (dt)
end

function love.draw ()
    ink:draw ()
end

function love.keypressed (key, scancode, isrepeat)
    ink:keypressed (key, scancode, isrepeat)
end

function love.keyreleased (key)
    ink:keyreleased (key)
end

function love.directorydropped ()
    ink:directorydroppeddirectorydropped ()
end

function love.filedropped (file)
    ink:filedropped (file)
end

function love.focus (focus)
    ink:focus (focus)
end

function love.lowmemory ()
    ink:lowmemorylowmemory ()
end

function love.mousefocus (focus)
    ink:mousefocus (focus)
end

function love.mousemoved (x, y, dx, dy, istouch)
    ink:mousemoved (x, y, dx, dy, istouch)
end

function love.mousepressed (x, y, button, istouch)
    ink:mousepressed (x, y, button, istouch)
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
