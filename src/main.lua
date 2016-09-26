ink = require "Ink/Ink"
-- arquivo exemplo (example file)

function love.load()
    ink:New_Instance("btn_teste", "Ink_button", {{50,20}, {200, 100}, "Teste do Ink"})
end

function love.update(dt)
    ink:Update(dt)
end

function love.draw()
    ink:Draw()
end
