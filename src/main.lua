ink = require "Ink/Ink"
-- arquivo exemplo (example file)

function love.load()
    ink:New_Instance("btn_teste", "Ink_button", {
        positionX = 230,
        positionY = 30,
        sizeX = 170,
        sizeY = 40,
        text = "Mudar texto de btn2",
        value = function ()
            if ink.instances["checkBOX"]:Get_Value() == true then
                ink.instances["btn_teste2"]:Set_Text(ink.instances["txtbx_teste"].value)
            end
    end})

    ink:New_Instance("btn_teste2", "Ink_button", {
        positionX = 20,
        positionY = 130,
        sizeX = 140,
        sizeY = 40,
        text = "btn2",
        value = function  ()
            ink.instances["btn_teste2"].localPos.x = ink.instances["btn_teste2"].localPos.x + 10
            ink.instances["checkBOX"]:InvertValue()
    end}, "btn_teste")

    ink:New_Instance("txtbx_teste", "Ink_textBox", {
        positionX = 20,
        positionY = 30,
        sizeX = 200,
        sizeY = 40,
        outlineSize = 5,
        value = "teste txt"})

    ink:New_Instance("checkBOX", "Ink_checkBox", {
        positionX = 420,
        positionY = 30,
        sizeX = 40,
        sizeY = 40,
        outlineSize = 8,
        value = false
    })

    ink:New_Instance("checkCircle", "Ink_checkCircle", {
        positionX = 500,
        positionY = 50,
        size = 20,
        outlineSize = 2,
        value = false
    })
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
