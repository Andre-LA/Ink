ink = require "Ink/Ink"
-- arquivo exemplo (example file)

function love.load()
    ink:New_Instance("btn_teste", "Ink_button", {{50,20}, {200, 100}, "teste"})
end

function love.update(dt)
    ink:Update(dt)
    --love.window.setTitle("FPS:" .. love.timer.getFPS())
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
