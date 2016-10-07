ink = require "Ink/Ink"
-- arquivo exemplo (example file)

local angle = 0;

function love.load()
    ink:New_Instance("btn_teste", "Ink_button", {{50,20}, {200, 100}, "teste"})
    ink:New_Instance("btn_teste2", "Ink_button", {{20,20}, {100, 100}, "teste2"}, "btn_teste")
end

function love.update(dt)
    ink:Update(dt)
    --love.window.setTitle("FPS:" .. love.timer.getFPS())
    angle = angle + dt
end

function love.draw()
    ink:Draw()
end

function love.mousepressed(x, y, button, isTouch)
    ink:MousePressed(x, y, button, isTouch)
end

function love.mousereleased(x, y, button, isTouch)
    ink:MouseReleased(x, y, button, isTouch)
end
