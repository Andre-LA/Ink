ink = require "Ink/Ink"
-- arquivo exemplo (example file)

function love.load()
    ink:New_Instance("btn_teste", "Ink_button", {positionX = 20, positionY = 20, sizeX = 200, sizeY = 120, text = "btn_teste2"})
    ink:New_Instance("btn_teste2", "Ink_button", {positionX = 20, positionY = 130, sizeX = 200, sizeY = 120, text = "btn_teste2"}, "btn_teste")
end

function love.update(dt)
    ink:Update(dt)
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
