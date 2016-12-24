ink = require "Ink/Ink"
-- arquivo exemplo (example file)

function love.load()
    ink:New_Instance("root", "Ink_textBox", {
        position = {10, 10},
        size = {30, 30},
        text = "r",
        value = function  ()
            ink.instances["root"]:Translate({math.random(-10, 10), math.random(10, -10)})
        end
    })
end

function love.update(dt)
    ink:update(dt)
    love.window.setTitle(love.timer.getFPS())
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
