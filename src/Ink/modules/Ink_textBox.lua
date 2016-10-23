class "Ink_textBox"

-- Create modules using this as reference

function Ink_textBox:Ink_textBox()
    -- ink properties:
    self.parent = ""
    self.parentPos = {x = 0, y = 0}
    self.isVisible = true
    self.geometry = "rectangle"
    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.value = "hi ^-^" --the .value property can be any type of value (number, string, function, etc)
    self.inHover = false

    self.colors = {
        txtArea = {250, 250, 250, 255},
        txtOutline = {150, 150, 150, 255},
        txtBackColor = {0, 0, 0, 40},
        txtColor = {50, 50, 50, 255}
    }

    self.outlineSize = 5;
    self.isActive = false
    self.deltaTime = 0
end

function Ink_textBox:Update_Parent (parent)
    self.parentPos = parent
end

function Ink_textBox:Set_Parent (name)
    self.parent = name;
end

function Ink_textBox:Ink_Start (values, inkLib)
    self.inkLib = inkLib

    self.pos.x = values.positionX
    self.pos.y = values.positionY
    self.size.x = values.sizeX
    self.size.y = values.sizeY
    self.outlineSize = values.outlineSize;
    self.value = values.value;
end

function Ink_textBox:Update (dt)
    self.deltaTime = self.deltaTime + dt

    if self.deltaTime > 0.6 then
        self.deltaTime = 0
        self.colors.txtBackColor[4] = self.colors.txtBackColor[4] == 40 and 0 or 40
    end
end

function Ink_textBox:Hover ()
end

function Ink_textBox:NotHover ()

end

function Ink_textBox:MousePressed (x, y, b)
    if self.inHover and self.isActive == not self.inHover then
        self.outlineSize = self.outlineSize * 1.5

        for i=1,#self.colors.txtOutline do
            self.colors.txtOutline[i] = self.colors.txtOutline[i] - 20
        end

    elseif not self.inHover and self.isActive == not self.inHover then
        self.outlineSize = self.outlineSize / 1.5

        for i=1,#self.colors.txtOutline do
            self.colors.txtOutline[i] = self.colors.txtOutline[i] + 20
        end
    end

    self.isActive = self.inHover
end

function Ink_textBox:MouseDown (x, y, b)

end

function Ink_textBox:MouseReleased (x, y, b)

end

function Ink_textBox:TextInput (text)
    self.value = self.value .. text
end

function Ink_textBox:KeyPressed (key, scancode, isrepeat)
    if key == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(self.value, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            self.value = string.sub(self.value, 1, byteoffset - 1)
        end
    end
end

function Ink_textBox:KeyReleased (key)

end

function Ink_textBox:Ink_Draw ()
    love.graphics.setColor(self.colors.txtOutline)
    love.graphics.rectangle("fill", self.pos.x + self.parentPos.x, self.pos.y + self.parentPos.y, self.size.x, self.size.y)

    love.graphics.setColor(self.colors.txtArea)
    love.graphics.rectangle("fill", self.pos.x  + self.outlineSize/2 + self.parentPos.x, self.pos.y  + self.outlineSize/2 + self.parentPos.y, self.size.x - self.outlineSize , self.size.y - self.outlineSize )

    if self.isActive then
        love.graphics.setColor(self.colors.txtBackColor)
        love.graphics.rectangle("fill", self.pos.x + self.outlineSize + 10 + self.parentPos.x + love.graphics.getFont():getWidth(self.value), self.pos.y + self.size.y/2 - (love.graphics.getFont():getHeight("a")/2) + self.parentPos.y, love.graphics.getFont():getWidth("a")/2, love.graphics.getFont():getHeight(self.value))
    end

    love.graphics.setColor(self.colors.txtColor)
    love.graphics.print(self.value, self.pos.x + self.outlineSize + 10 + self.parentPos.x, self.pos.y + self.size.y/2 - (love.graphics.getFont():getHeight("a")/2) + self.parentPos.y)
end

function Ink_textBox:Get_Value ()
    return self.value
end

function Ink_textBox:Set_Value (newValue)
    self.value = newValue
end

return Ink_textBox()
