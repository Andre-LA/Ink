-- arquivo de demonstração (demo file)

local Ink = require "Ink/ink"
local ink = Ink.new(true, love.graphics.getWidth(), love.graphics.getHeight())

function love.load()
    local titulo = ink:createElement("Título (title)", 1, {
        posZ = 4,
        anchors = {left=1, right=1, up=1, down=0},
        offset  = {left=0, right=0, up=0, down=-30},
        velocity = 5,
    })
    local painel_esquerdo = ink:createElement("Painel esquerdo (left pannel)", 1, {
        posZ = 3,
        anchors = {left=1, right=0, up=1, down=1},
        offset  = {left=0, right=-150, up=30, down=0},
        velocity = 5,
    })
    local conteudo = ink:createElement("Conteúdo (content)", 1, {
        posZ = 2,
        offset  = {left=150, right=0, up=30, down=0},
        velocity = 5,
    })
    local filho_conteudo = ink:createElement("Filho (child)", 1, {
        posZ = 1,
        anchors = {left=0.7, right=0.7, up=0.7, down=0.7},
        velocity = 5,
        parentId = conteudo,
    })
    local imagem_filho = ink:createElement("Imagem (image)", 1, {
        anchors = {up=0.8, right=0.8, down=0.8, left=0.8},
        velocity = 5,
        parentId = filho_conteudo,
        preserveAspectRatio = true,
    })

    ink:getElement(titulo):addComponent("Ink/components/love/draw_image", {
        image = love.graphics.newImage("image_test/image_test.png")
    })

    ink:getElement(painel_esquerdo):addComponent("Ink/components/love/draw_image", {
        image = love.graphics.newImage("image_test/image_test.png")
    })

    ink:getElement(conteudo):addComponent("Ink/components/love/draw_image", {
        image = love.graphics.newImage("image_test/image_test.png")
    })

    ink:getElement(imagem_filho):addComponent("Ink/components/love/draw_image", {
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
    })

    ink:getElement(imagem_filho):addComponent("Ink/components/love/button", {
        colorWhenClicked={255,255,255,150},
        onClickFunction = function(self, x, y, button, istouch)
            print "Olá Mundo!"
        end,
    })

    if ink.devMode then
        ink:getElement(titulo):addComponent("Ink/components/love/rect_transform_viewer", {})
        ink:getElement(painel_esquerdo):addComponent("Ink/components/love/rect_transform_viewer", {})
        ink:getElement(conteudo):addComponent("Ink/components/love/rect_transform_viewer", {})
        ink:getElement(filho_conteudo):addComponent("Ink/components/love/rect_transform_viewer", {})
        ink:getElement(imagem_filho):addComponent("Ink/components/love/rect_transform_viewer", {})
    end
end

function love.update (dt)
    love.window.setTitle("Q/S (fps): [" .. love.timer.getFPS() .. "]")
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
