ink = require "Ink/Ink"
-- arquivo exemplo (example file)

function firstDemo ()
    ink:New_Instance("btn_teste", "Ink_button", {
        position = {230, 30},
        size = {170, 40},
        text = "Mudar texto de btn2",
        value = function ()
            if ink.instances["checkBOX"]:Get_Value() == true then
                ink.instances["btn_teste2"]:Set_Text(ink.instances["txtbx_teste"].value)
            end
        end})

    ink:New_Instance("btn_teste2", "Ink_button", {
        position = {20, 130},
        size = {140, 40},
        text = "btn2",
        value = function  ()
            ink.instances["btn_teste2"].localPos.x = ink.instances["btn_teste2"].localPos.x + 10
            ink.instances["checkBOX"]:InvertValue()
    end}, "btn_teste")

    ink:New_Instance("txtbx_teste", "Ink_textBox", {
        position = {20, 30},
        size = {200, 40},
        outlineSize = 5,
        value = "teste txt"})

    ink:New_Instance("checkBOX", "Ink_checkBox", {
        position = {420, 30},
        size = {40, 40},
        outlineSize = 8,
        value = false
    })

    ink:New_Instance("checkCircle", "Ink_checkCircle", {
        position = {500, 50},
        size = 20,
        outlineSize = 2,
        value = false
    })
end

function CalculatorDemo ()
    resultValue = 0
    memoValue = 0
    manageResult = true
    op = "n"

    -- Result box:
    ink:New_Instance("txtbx_results", "Ink_textBox", {
        position = {20, 20},
        size = {460, 40},
        outlineSize = 5,
        value = tostring(resultValue)
    })

    -- Create number buttons
    for i=1,3 do
        for j=1,3 do
            ink:New_Instance("btn_number" .. tostring(3*(i-1)+j), "Ink_button", {
                position = {120 * j - 100, 120 * i + 40 - 80},
                size = {100, 100},
                text =  tostring(3*(i-1)+j),
                value = function  ()
                    if (manageResult) then
                        resultValue = resultValue * 10 + tonumber(ink.instances["btn_number" .. tostring(3*(i-1)+j)].text)
                        ink.instances["txtbx_results"].value = tostring(resultValue)
                    else
                        memoValue = memoValue * 10 + tonumber(ink.instances["btn_number" .. tostring(3*(i-1)+j)].text)
                        ink.instances["txtbx_results"].value = tostring(memoValue)
                    end
                end
            })
        end
    end
    ink:New_Instance("btn_number0", "Ink_button", {
        position = {140, 440},
        size = {100, 100},
        text =  "0",
        value = function  ()
            if (manageResult) then
                resultValue = resultValue * 10 + tonumber(ink.instances["btn_number0"].text)
                ink.instances["txtbx_results"].value = tostring(resultValue)
            else
                memoValue = memoValue * 10 + tonumber(ink.instances["btn_number0"].text)
                ink.instances["txtbx_results"].value = tostring(memoValue)
            end
        end
    })

    -- Create operation buttons
    ink:New_Instance("btn_op_plus", "Ink_button", {
        position = {380, 80},
        size = {100, 100},
        text = "+",
        value = function ()
            manageResult = false
            op = "+"
        end
    })
    ink:New_Instance("btn_op_minus", "Ink_button", {
        position = {380, 200},
        size = {100, 100},
        text = "-",
        value = function ()
            manageResult = false
            op = "-"
        end
    })
    ink:New_Instance("btn_op_division", "Ink_button", {
        position = {380, 320},
        size = {100, 100},
        text = "/",
        value = function ()
            manageResult = false
            op = "/"
        end
    })
    ink:New_Instance("btn_op_times", "Ink_button", {
        position = {380, 440},
        size = {100, 100},
        text = "*",
        value = function ()
            manageResult = false
            op = "*"
        end
    })

    -- equal and reset buttons
    ink:New_Instance("btn_op_eq", "Ink_button", {
        position = {260, 440},
        size = {100, 100},
        text = "=",
        value = function ()
            manageResult = true
            if op == "+" then
                resultValue = resultValue + memoValue
            elseif op == "-" then
                resultValue = resultValue - memoValue
            elseif op == "/" then
                resultValue = resultValue / memoValue
            elseif op == "*" then
                resultValue = resultValue * memoValue
            end
            ink.instances["txtbx_results"].value = tostring(resultValue)
            memoValue = 0
        end
    })
    ink:New_Instance("btn_op_reset", "Ink_button", {
        position = {20, 440},
        size = {100, 100},
        text = "R",
        value = function ()
            manageResult = true
            resultValue = 0
            memoValue = 0
            ink.instances["txtbx_results"].value = tostring(resultValue)
        end
    })
end

function Switch ()
    ink:New_Instance("Btn_switch", "Ink_button", {
        position = {love.graphics.getWidth() - 100, 10},
        size = {80, 20},
        text = "Switch",
        value = function  ()
            if cena == 1 then
                ink:Delete_All_Instances()
                Switch()
                CalculatorDemo()
                cena = 2
            else
                ink:Delete_All_Instances()
                Switch()
                firstDemo()
                cena = 1
            end
        end
    })
    ink.instances["Btn_switch"].posInterpolDisabled = true
end

function love.load()
    cena = 1
    Switch()
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
