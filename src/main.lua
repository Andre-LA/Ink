ink = require "Ink/Ink"
-- arquivo exemplo (example file)

function love.load()
    ink:New_Instance("btn_teste", "Ink_button", {positionX = 20, positionY = 20, sizeX = 200, sizeY = 120, text = "btn_teste pai", value = function ()
        print("oi botao teste")
    end})
    ink:New_Instance("btn_teste2", "Ink_button", {positionX = 20, positionY = 130, sizeX = 200, sizeY = 120, text = "btn_teste filho", value = function  ()
        ink.instances["btn_teste"].pos.x = ink.instances["btn_teste"].pos.x+10
        print("oi botao teste 2")
    end}, "btn_teste")
    ink:New_Instance("txtbx_teste", "Ink_textBox", {positionX = 400, positionY = 130, sizeX = 200, sizeY = 40, outlineSize = 5, value = "teste txt"})
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

function love.textinput(text)
    ink:TextInput(text)
end

function love.keypressed(key, scancode, isrepeat)
    ink:Keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key)
    ink:Keyreleased(key)
end
