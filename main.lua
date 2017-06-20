-- arquivo de demonstração (demo file)

local Ink = require "ink/ink"
local ink = Ink(true, "rect_transform",{
    -- ordem de processamento (exceto draw)
    "rect_transform",
    "button",
    "draw_image",
    "text",
    "rect_transform_viewer",
}, {
    -- ordem dos draws
    "draw_image",
    "button",
    "text",
    "rect_transform_viewer",
})

local top_menu    = {}
local left_pannel = {}
local content_pannel = {}
local child_content  = {}

local images = {
    leftup = love.graphics.newImage("image_test/9sliced/up_left.png"),
    up = love.graphics.newImage("image_test/9sliced/up.png"),
    upright = love.graphics.newImage("image_test/9sliced/up_right.png"),

    left = love.graphics.newImage("image_test/9sliced/left.png"),
    center = love.graphics.newImage("image_test/9sliced/center.png"),
    right = love.graphics.newImage("image_test/9sliced/right.png"),

    downleft = love.graphics.newImage("image_test/9sliced/left_down.png"),
    down = love.graphics.newImage("image_test/9sliced/down.png"),
    rightdown = love.graphics.newImage("image_test/9sliced/down_right.png"),
}

local total_up, total_d = 0, 0
local qtd_up, qtd_d = 0, 0

function love.update (dt)
    local t1 = love.timer.getTime()

    love.window.setTitle("Ink Demo: q/s (fps): [" .. love.timer.getFPS() .. "]")

    ink:doComponentsFunction("update", dt)
    ink:doComponentsFunction("lateupdate", dt)

    local t2 = love.timer.getTime()

    if qtd_up < 20000 then
        qtd_up=qtd_up+1
        total_up = total_up + (t2-t1)
        print ("tempo de update consumido: ", (t2-t1))

    end
end

function love.load()
    ink:addComponent "ui_components/rect_transform"
    ink:addComponent "ui_components/draw_image"
    ink:addComponent "ui_components/rect_transform_viewer"
    ink:addComponent "ui_components/text"
    ink:addComponent "ui_components/button"
    --[[
    top_menu    = ink:createEntity "top menu"
    left_pannel = ink:createEntity "left pannel"
    content_pannel = ink:createEntity "content pannel"
    child_content  = ink:createEntity ("child content", content_pannel)

    -- top menu
    ink:attachEntity ("rect_transform", top_menu, {
        anchors = {up = 1, left = 1, right = 1, down = 0},
        offset = {up = 0, left = 0, right = 0, down = -30},
    })
    ink:attachEntity("rect_transform_viewer", top_menu, {useText = true})
    ink:attachEntity("draw_image", top_menu, {useSliced = true, images = images, imageColor = {230, 120,120,255}})

    -- left pannel
    ink:attachEntity("rect_transform", left_pannel, {
        anchors = {up = 1, left = 1, down = 1, right = 0},
        offset = {up = 30, left = 0, down = 0, right = -100}
    })
    ink:attachEntity("rect_transform_viewer", left_pannel, {useText = true})
    ink:attachEntity("draw_image", left_pannel, {useSliced = true, images = images, imageColor = {230, 120,120,255}})

    -- content pannel
    ink:attachEntity("rect_transform", content_pannel, {
        anchors = {up = 1, left = 1, down = 1, right = 1},
        offset = {up = 30, left = 100, down = 0, right = 0}
    })
    ink:attachEntity("rect_transform_viewer", content_pannel, {useText = true})
    ink:attachEntity("draw_image", content_pannel, {useSliced = true, images = images, imageColor = {230, 120,120,255}})

    -- child content
    ink:attachEntity("rect_transform", child_content, {
        anchors = {up = 0.6, left = 0.6, down = 0.6, right = 0.6},
        offset = {up = 0, left = 0, right = 0, down = 0},
        position = {x=0, y=0, z=2}
    })
    ink:attachEntity("rect_transform_viewer", child_content, {useText = true})
    ink:attachEntity("draw_image", child_content, {useSliced = true, images = images, imageColor = {230, 120,120,255}})
    ink:attachEntity("text", child_content, {
        text = {{0,255,255,255}, "TESTANDO INK LÖVE FRAMEWoRK"},
        offsets={y=-20,x=0},
        horizontalAlign = "center",
        editable = true,
    })
    ink:attachEntity("button", child_content, {
        onClick = function (ink, entity)
            entity.text.inEdit = true
        end,
        offClick = function (ink, entity)
            entity.text.inEdit = false
        end,
    })
    --]]


    for i=1,80 do
        local e = ink:createEntity("oi" .. i)
        ink:attachEntity("rect_transform", e, {})
        --ink:attachEntity("rect_transform_viewer", e, {})
        ink:attachEntity("draw_image", e, {image = love.graphics.newImage("image_test/image_test.png"), useSliced=false})
    end
end

function love.draw ()
    local t1 = love.timer.getTime()

    ink:doComponentsFunction("draw")

    local t2 = love.timer.getTime()

    if qtd_d < 20000 then
        qtd_d=qtd_d+1
        total_d = total_d + (t2-t1)
        print ("tempo de draw consumido: ", (t2-t1) .. "\n")
    end
end

function love.keypressed (key, scancode, isrepeat)
    ink:doComponentsFunction("keypressed", key, scancode, isrepeat)
end
function love.keyreleased (key)
    ink:doComponentsFunction("keyreleased", key)
end
function love.directorydropped ()
    ink:doComponentsFunction("directorydropped")
end
function love.filedropped (file)
    ink:doComponentsFunction("filedropped", file)
end
function love.focus (focus)
    ink:doComponentsFunction("focus", focus)
end
function love.lowmemory ()
    ink:doComponentsFunction("lowmemory")
end
function love.mousefocus (focus)
    ink:doComponentsFunction("mousefocus", focus)
end
function love.mousemoved (x, y, dx, dy, istouch)
    ink:doComponentsFunction("mousemoved", x, y, dx, dy, istouch)
end
function love.mousepressed (x, y, button, istouch)
    ink:doComponentsFunction("mousepressed", x, y, button, istouch)
end
function love.mousereleased (x, y, button, istouch)
    ink:doComponentsFunction("mousereleased", x, y, button, istouch)
end
function love.quit()
    ink:doComponentsFunction("quit")
end
function love.touchmoved (id, x, y, dx, dy, pressure)
    ink:doComponentsFunction("touchmoved", id, x, y, dx, dy, pressure)
end
function love.touchpressed (id, x, y, dx, dy, pressure)
    ink:doComponentsFunction("touchpressed", id, x, y, dx, dy, pressure)
end
function love.touchreleased (id, x, y, dx, dy, pressure)
    ink:doComponentsFunction("touchreleased", id, x, y, dx, dy, pressure)
end
function love.visible(visible)
    ink:doComponentsFunction("visible", visible)
end
function love.wheelmoved (x, y)
    ink:doComponentsFunction("wheelmoved", x, y)
end
function love.resize(w, h)
    ink:doComponentsFunction("resize", w, h)
end
function love.textinput (text)
    ink:doComponentsFunction("textinput", text)
end
function love.textedited (text, start, length)
    ink:doComponentsFunction("textedited", text, start, length)
end
function love.gamepadaxis (joystick, axis, value)
    ink:doComponentsFunction("gamepadaxis", joystick, axis, value)
end
function love.gamepadpressed (joystick, button)
    ink:doComponentsFunction("gamepadpressed", joystick, button)
end
function love.gamepadreleased (joystick, button)
    ink:doComponentsFunction("gamepadreleased", joystick, button)
end
function love.joystickadded (joystick)
    ink:doComponentsFunction("joystickadded", joystick)
end
function love.joystickaxis (joystick, axis, value)
    ink:doComponentsFunction("joystickaxis", joystick, axis, value)
end
function love.joystickhat (joystick, hat, direction)
    ink:doComponentsFunction("joystickhat", joystick, hat, direction)
end
function love.joystickpressed (joystick, button)
    ink:doComponentsFunction("joystickpressed", joystick, button)
end
function love.joystickreleased (joystick, button)
    ink:doComponentsFunction("joystickreleased", joystick, button)
end
function love.joystickremoved (joystick)
    ink:doComponentsFunction("joystickremoved", joystick)
end
