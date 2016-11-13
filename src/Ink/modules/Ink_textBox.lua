local Module = {}
function Module:New()
    -- ink properties:
    self.parent = "Ink_origin"
    self.parentPos = {x = 0, y = 0}
    self.localPos = {x = 0, y = 0}
    self.pos = {x = 0, y = 0}
    self.size = {x = 0, y = 0}
    self.isVisible = true
    self.geometry = "rectangle"
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

    local nw = {}
    setmetatable(nw, {__index = self})
    return nw
end

function Module:Set_Parent (name)
    self.parent = name;
end

function Module:Ink_Start (values, inkLib)
    self.inkLib = inkLib

    self.localPos.x = values.position[1]
    self.localPos.y = values.position[2]
    self.size.x = values.size[1]
    self.size.y = values.size[2]
    self.outlineSize = values.outlineSize;
    self.value = values.value;
end

function Module:Update (dt)
    if isActive then
        self.deltaTime = self.deltaTime + dt

        if self.deltaTime > 0.6 then
            self.deltaTime = 0
            self.colors.txtBackColor[4] = self.colors.txtBackColor[4] == 40 and 0 or 40
        end
    end
end

function Module:Hover ()
end

function Module:NotHover ()

end

function Module:MousePressed (x, y, b)
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

function Module:MouseDown (x, y, b)

end

function Module:MouseReleased (x, y, b)

end

function Module:TextInput (text)
    self.value = self.value .. text
end

function Module:KeyPressed (key, scancode, isrepeat)
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

function Module:KeyReleased (key)

end

function Module:Ink_Draw ()
    -- Draw fist background, this background will be the outline
    love.graphics.setColor(self.colors.txtOutline)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    -- Draw the background
    love.graphics.setColor(self.colors.txtArea)
    love.graphics.rectangle("fill", self.pos.x  + self.outlineSize/2, self.pos.y  + self.outlineSize/2, self.size.x - self.outlineSize , self.size.y - self.outlineSize )

    -- if active (edit mode), draw the cursor
    if self.isActive then
        love.graphics.setColor(self.colors.txtBackColor)
        love.graphics.rectangle("fill", self.pos.x + self.outlineSize + 10 + love.graphics.getFont():getWidth(self.value), self.pos.y + self.size.y/2 - (love.graphics.getFont():getHeight("a")/2), love.graphics.getFont():getWidth("a")/2, love.graphics.getFont():getHeight(self.value))
    end

    -- Draw the text
    love.graphics.setColor(self.colors.txtColor)
    love.graphics.print(self.value, self.pos.x + self.outlineSize + 10, self.pos.y + self.size.y/2 - (love.graphics.getFont():getHeight("a")/2))
end

function Module:Get_Value ()
    return self.value
end

function Module:Set_Value (newValue)
    self.value = type(newValue) == "string" and newValue or tostring(newValue)
end

return Module:New()
