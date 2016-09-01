ink = require "Ink/Ink"

function love.load()
    ink:New_Instance("btn_teste", "Ink_button", {{50,20}, {100,50}, "Teste do Ink"})
end

function love.update(dt)
end

function love.draw()
    ink:Draw()
end
