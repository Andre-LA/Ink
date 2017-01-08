ink = require "Ink/Ink"
-- arquivo exemplo (example file)

function love.load()
    cont = 0
end

function love.update(dt)
    ink:update(dt)
    love.window.setTitle("cont: " .. cont .. " | fps: " .. love.timer.getFPS() .. "  |  dt: " .. string.sub(tostring(dt*1000), 1, 6))

    if love.keyboard.isDown("k") then
        cont = cont +1
        ink:New_Instance("hi" .. cont, "Ink_Button", {
            position = {math.random(100, 500), math.random(100, 600)},
            size = {70, 30},
            value = function  ()

            end,
            text = "oi"
        })
    end
end

function love.draw()
    ink:draw()
end

function love.mousepressed(x, y, button, isTouch)
    ink:mousepressed(x, y, button, isTouch)
end

function love.mousereleased(x, y, button, isTouch)
    ink:mousereleased(x, y, button, isTouch)
end

function love.textinput(text)
    ink:textinput(text)
end

function love.keypressed(key, scancode, isrepeat)
    ink:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key)
    ink:keyreleased(key)
end
